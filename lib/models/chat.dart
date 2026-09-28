class Chat {
  const Chat({
    required this.id,
    required this.participantIds,
    required this.lastMessage,
    required this.lastMessageTime,
    this.isPinned = false,
    this.unreadCount = 0,
    this.isGroup = false,
    this.groupName,
    this.groupAvatarUrl,
  });

  final String id;
  final List<String> participantIds;
  final String lastMessage;
  final DateTime lastMessageTime;
  final bool isPinned;
  final int unreadCount;
  final bool isGroup;
  final String? groupName;
  final String? groupAvatarUrl;
}
