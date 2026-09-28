import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../models/group.dart';
import '../../services/chat_service.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/search_field.dart' show EmptyState;
import '../../widgets/user_avatar.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = ChatService.instance.groups;

    return AppScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Groups'),
        actions: [
          IconButton(
            icon: const Icon(Icons.group_add_outlined),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.group_add),
        label: const Text('Create group'),
      ),
      body: groups.isEmpty
          ? const EmptyState(
              icon: Icons.groups_outlined,
              title: 'No groups yet',
              subtitle: 'Create a group to chat with multiple people',
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(
                vertical: AppConstants.spacingSm,
              ),
              itemCount: groups.length,
              separatorBuilder: (_, _) => const Divider(height: 1, indent: 72),
              itemBuilder: (context, index) {
                final group = groups[index];
                return _GroupListTile(group: group, index: index);
              },
            ),
    );
  }
}

class _GroupListTile extends StatelessWidget {
  const _GroupListTile({
    required this.group,
    required this.index,
  });

  final ChatGroup group;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMd,
        vertical: AppConstants.spacingXs,
      ),
      leading: UserAvatar(imageUrl: group.avatarUrl, radius: 26),
      title: Text(
        group.name,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      subtitle: Text(
        '${group.memberIds.length} members · ${group.description}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 60 * index), duration: 300.ms)
        .slideX(begin: 0.05);
  }
}
