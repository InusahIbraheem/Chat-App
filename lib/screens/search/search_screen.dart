import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_routes.dart';
import '../../services/chat_service.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/chat_list_tile.dart';
import '../../widgets/search_field.dart' show EmptyState, SearchField;
import '../../widgets/user_avatar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _query = _searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final service = ChatService.instance;
    final chatResults = service.searchChats(_query);
    final userResults = _query.isEmpty
        ? <dynamic>[]
        : service.users
            .where(
              (u) => u.name.toLowerCase().contains(_query.toLowerCase()),
            )
            .toList();

    return AppScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            child: SearchField(
              controller: _searchController,
              hintText: 'Search messages, chats, contacts...',
              onChanged: (value) => setState(() => _query = value),
            ),
          ),
          if (_query.isEmpty)
            Expanded(
              child: EmptyState(
                icon: Icons.search,
                title: 'Search for anything',
                subtitle: 'Find chats, contacts, and messages',
              ),
            )
          else
            Expanded(
              child: ListView(
                children: [
                  if (chatResults.isNotEmpty) ...[
                    _SectionHeader(title: 'Chats (${chatResults.length})'),
                    ...chatResults.asMap().entries.map((entry) {
                      return ChatListTile(
                        chat: entry.value,
                        onTap: () => context.push(
                          AppRoutes.conversationPath(entry.value.id),
                        ),
                      )
                          .animate()
                          .fadeIn(
                            delay: Duration(milliseconds: 40 * entry.key),
                          );
                    }),
                  ],
                  if (userResults.isNotEmpty) ...[
                    _SectionHeader(title: 'Contacts (${userResults.length})'),
                    ...userResults.asMap().entries.map((entry) {
                      final user = entry.value;
                      return ListTile(
                        leading: UserAvatar(
                          imageUrl: user.avatarUrl,
                          radius: 22,
                          showOnlineIndicator: true,
                          isOnline: user.isOnline,
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.bio),
                        onTap: () {},
                      ).animate().fadeIn(
                            delay: Duration(milliseconds: 40 * entry.key),
                          );
                    }),
                  ],
                  if (chatResults.isEmpty && userResults.isEmpty)
                    const EmptyState(
                      icon: Icons.search_off,
                      title: 'No results found',
                      subtitle: 'Try a different search term',
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.spacingMd,
        AppConstants.spacingMd,
        AppConstants.spacingMd,
        AppConstants.spacingSm,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
