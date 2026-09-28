import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/utils/format_utils.dart';
import '../models/chat.dart';
import '../services/chat_service.dart';
import 'user_avatar.dart';

class ChatListTile extends StatelessWidget {
  const ChatListTile({
    super.key,
    required this.chat,
    required this.onTap,
  });

  final Chat chat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final service = ChatService.instance;
    final displayName = service.getChatDisplayName(chat);
    final avatarUrl = service.getChatAvatarUrl(chat);
    final otherUser = service.getOtherParticipant(chat);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMd,
        vertical: AppConstants.spacingXs,
      ),
      leading: UserAvatar(
        imageUrl: avatarUrl,
        radius: 26,
        showOnlineIndicator: otherUser != null,
        isOnline: otherUser?.isOnline ?? false,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              displayName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: chat.unreadCount > 0
                        ? FontWeight.w700
                        : FontWeight.w500,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            FormatUtils.formatMessageTime(chat.lastMessageTime),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: chat.unreadCount > 0
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              chat.lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: chat.unreadCount > 0
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
            ),
          ),
          if (chat.unreadCount > 0)
            Container(
              margin: const EdgeInsets.only(left: AppConstants.spacingSm),
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${chat.unreadCount}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
        ],
      ),
      onTap: onTap,
    );
  }
}
