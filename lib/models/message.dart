enum MessageType { text, image, voice, video, file }

class Message {
  const Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.timestamp,
    this.type = MessageType.text,
    this.isRead = false,
    this.isSent = true,
  });

  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final MessageType type;
  final bool isRead;
  final bool isSent;

  bool get isDelivered => isSent && !isRead;
}
