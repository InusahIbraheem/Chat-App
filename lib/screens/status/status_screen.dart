import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/format_utils.dart';
import '../../models/status.dart';
import '../../services/chat_service.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/user_avatar.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = ChatService.instance;
    final colorScheme = Theme.of(context).colorScheme;
    final statuses = service.statuses;

    return AppScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Status'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.camera_alt),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingSm),
        children: [
          ListTile(
            leading: Stack(
              children: [
                UserAvatar(
                  imageUrl: service.currentUser.avatarUrl,
                  radius: 26,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add,
                      size: 14,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
            title: const Text('My status'),
            subtitle: Text(
              'Tap to add status update',
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
            onTap: () {},
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppConstants.spacingMd,
              AppConstants.spacingMd,
              AppConstants.spacingMd,
              AppConstants.spacingSm,
            ),
            child: Text(
              'Recent updates',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          ...statuses.asMap().entries.map((entry) {
            final index = entry.key;
            final status = entry.value;
            return _StatusTile(status: status, index: index);
          }),
        ],
      ),
    );
  }
}

class _StatusTile extends StatelessWidget {
  const _StatusTile({
    required this.status,
    required this.index,
  });

  final StatusUpdate status;
  final int index;

  @override
  Widget build(BuildContext context) {
    final service = ChatService.instance;
    final user = service.getUserById(status.userId);
    final colorScheme = Theme.of(context).colorScheme;

    if (user == null) return const SizedBox.shrink();

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: status.isViewed
              ? null
              : LinearGradient(
                  colors: [
                    colorScheme.primary,
                    colorScheme.secondary,
                  ],
                ),
          border: status.isViewed
              ? Border.all(color: colorScheme.outline)
              : null,
        ),
        child: UserAvatar(imageUrl: user.avatarUrl, radius: 24),
      ),
      title: Text(user.name),
      subtitle: Text(
        '${status.content} · ${FormatUtils.formatMessageTime(status.timestamp)}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        '${status.viewCount} views',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
      ),
      onTap: () {},
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 50 * index), duration: 300.ms);
  }
}
