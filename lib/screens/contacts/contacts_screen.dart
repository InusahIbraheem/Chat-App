import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_routes.dart';
import '../../services/chat_service.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/search_field.dart' show EmptyState, SearchField;
import '../../widgets/user_avatar.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final service = ChatService.instance;
    final users = service.users.where((user) {
      if (_query.isEmpty) return true;
      return user.name.toLowerCase().contains(_query.toLowerCase());
    }).toList();

    return AppScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Contacts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_outlined),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.person_add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            child: SearchField(
              controller: _searchController,
              hintText: 'Search contacts...',
              onChanged: (value) => setState(() => _query = value),
            ),
          ),
          Expanded(
            child: users.isEmpty
                ? const EmptyState(
                    icon: Icons.contacts_outlined,
                    title: 'No contacts found',
                  )
                : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ListTile(
                        leading: UserAvatar(
                          imageUrl: user.avatarUrl,
                          radius: 24,
                          showOnlineIndicator: true,
                          isOnline: user.isOnline,
                        ),
                        title: Text(user.name),
                        subtitle: Text(
                          user.isOnline ? 'Online' : user.bio,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chat_bubble_outline),
                              onPressed: () {
                                final chat = service.chats.firstWhere(
                                  (c) =>
                                      !c.isGroup &&
                                      c.participantIds.contains(user.id),
                                  orElse: () => service.chats.first,
                                );
                                context.push(
                                  AppRoutes.conversationPath(chat.id),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.call_outlined),
                              onPressed: () => context.push(
                                AppRoutes.voiceCallPath(user.id),
                              ),
                            ),
                          ],
                        ),
                      )
                          .animate()
                          .fadeIn(
                            delay: Duration(milliseconds: 40 * index),
                            duration: 300.ms,
                          );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
