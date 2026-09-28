enum StatusType { text, image, video }

class StatusUpdate {
  const StatusUpdate({
    required this.id,
    required this.userId,
    required this.content,
    required this.timestamp,
    this.type = StatusType.text,
    this.viewCount = 0,
    this.isViewed = false,
  });

  final String id;
  final String userId;
  final String content;
  final DateTime timestamp;
  final StatusType type;
  final int viewCount;
  final bool isViewed;
}
