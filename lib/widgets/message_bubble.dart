import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/utils/format_utils.dart';
import '../models/message.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  final Message message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.75,
        ),
        margin: EdgeInsets.only(
          left: isMe ? AppConstants.spacingXl : AppConstants.spacingSm,
          right: isMe ? AppConstants.spacingSm : AppConstants.spacingXl,
          bottom: AppConstants.spacingSm,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingMd,
          vertical: AppConstants.spacingSm + 2,
        ),
        decoration: BoxDecoration(
          color: isMe
              ? colorScheme.primary
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppConstants.radiusLg),
            topRight: const Radius.circular(AppConstants.radiusLg),
            bottomLeft: Radius.circular(isMe ? AppConstants.radiusLg : 4),
            bottomRight: Radius.circular(isMe ? 4 : AppConstants.radiusLg),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isMe
                        ? colorScheme.onPrimary
                        : colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  FormatUtils.formatMessageTime(message.timestamp),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: isMe
                            ? colorScheme.onPrimary.withValues(alpha: 0.7)
                            : colorScheme.onSurfaceVariant,
                        fontSize: 10,
                      ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  Icon(
                    message.isRead
                        ? Icons.done_all
                        : message.isSent
                            ? Icons.done
                            : Icons.schedule,
                    size: 14,
                    color: message.isRead
                        ? colorScheme.tertiary
                        : colorScheme.onPrimary.withValues(alpha: 0.7),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
