class ChatGroup {
  const ChatGroup({
    required this.id,
    required this.name,
    required this.description,
    required this.memberIds,
    required this.avatarUrl,
    this.createdAt,
  });

  final String id;
  final String name;
  final String description;
  final List<String> memberIds;
  final String avatarUrl;
  final DateTime? createdAt;
}
