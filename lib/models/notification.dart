enum NotificationType { message, call, group, system }

class AppNotification {
  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    this.type = NotificationType.message,
    this.isRead = false,
    this.relatedUserId,
    this.relatedChatId,
  });

  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final NotificationType type;
  final bool isRead;
  final String? relatedUserId;
  final String? relatedChatId;
}
