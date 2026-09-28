import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_routes.dart';
import '../../services/chat_service.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/chat_list_tile.dart';
import '../../widgets/search_field.dart' show EmptyState, SearchField;

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
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
    final chats = _query.isEmpty
        ? service.chats
        : service.searchChats(_query);
    final unreadCount = service.unreadNotificationCount;

    return AppScaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(
            icon: Badge(
              isLabelVisible: unreadCount > 0,
              label: Text('$unreadCount'),
              child: const Icon(Icons.notifications_outlined),
            ),
            onPressed: () => context.push(AppRoutes.notifications),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push(AppRoutes.search),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'profile':
                  context.push(AppRoutes.profile);
                case 'settings':
                  context.push(AppRoutes.settings);
                case 'contacts':
                  context.push(AppRoutes.contacts);
                case 'groups':
                  context.push(AppRoutes.groups);
                case 'status':
                  context.push(AppRoutes.status);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'profile', child: Text('Profile')),
              PopupMenuItem(value: 'contacts', child: Text('Contacts')),
              PopupMenuItem(value: 'groups', child: Text('Groups')),
              PopupMenuItem(value: 'status', child: Text('Status')),
              PopupMenuItem(value: 'settings', child: Text('Settings')),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.contacts),
        icon: const Icon(Icons.edit_outlined),
        label: const Text('New chat'),
      ),
      body: CenteredContent(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppConstants.spacingMd,
                AppConstants.spacingSm,
                AppConstants.spacingMd,
                AppConstants.spacingSm,
              ),
              child: SearchField(
                controller: _searchController,
                hintText: 'Search chats...',
                onChanged: (value) => setState(() => _query = value),
              ),
            ),
            _QuickActionsRow(
              onContacts: () => context.push(AppRoutes.contacts),
              onGroups: () => context.push(AppRoutes.groups),
              onStatus: () => context.push(AppRoutes.status),
            ),
            Expanded(
              child: chats.isEmpty
                  ? const EmptyState(
                      icon: Icons.chat_bubble_outline,
                      title: 'No chats found',
                      subtitle: 'Start a new conversation',
                    )
                  : ListView.separated(
                      itemCount: chats.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final chat = chats[index];
                        return ChatListTile(
                          chat: chat,
                          onTap: () => context.push(
                            AppRoutes.conversationPath(chat.id),
                          ),
                        )
                            .animate()
                            .fadeIn(
                              delay: Duration(milliseconds: 50 * index),
                              duration: 300.ms,
                            )
                            .slideX(begin: 0.05);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow({
    required this.onContacts,
    required this.onGroups,
    required this.onStatus,
  });

  final VoidCallback onContacts;
  final VoidCallback onGroups;
  final VoidCallback onStatus;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMd,
        vertical: AppConstants.spacingSm,
      ),
      child: Row(
        children: [
          Expanded(
            child: _QuickActionChip(
              icon: Icons.contacts_outlined,
              label: 'Contacts',
              color: colorScheme.primaryContainer,
              onTap: onContacts,
            ),
          ),
          const SizedBox(width: AppConstants.spacingSm),
          Expanded(
            child: _QuickActionChip(
              icon: Icons.groups_outlined,
              label: 'Groups',
              color: colorScheme.secondaryContainer,
              onTap: onGroups,
            ),
          ),
          const SizedBox(width: AppConstants.spacingSm),
          Expanded(
            child: _QuickActionChip(
              icon: Icons.auto_stories_outlined,
              label: 'Status',
              color: colorScheme.tertiaryContainer,
              onTap: onStatus,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  const _QuickActionChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppConstants.spacingMd,
          ),
          child: Column(
            children: [
              Icon(icon, size: 24),
              const SizedBox(height: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
