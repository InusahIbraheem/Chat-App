import '../models/chat.dart';
import '../models/group.dart';
import '../models/message.dart';
import '../models/notification.dart';
import '../models/status.dart';
import '../models/user.dart';

class ChatService {
  ChatService._();
  static final ChatService instance = ChatService._();

  static const String currentUserId = 'user_me';

  final User currentUser = const User(
    id: currentUserId,
    name: 'Inusah Ibraheem',
    avatarUrl: 'https://i.pravatar.cc/150?img=68',
    email: 'inusah@example.com',
    phone: '+233 24 000 0000',
    bio: 'Building beautiful chat experiences.',
    isOnline: true,
  );

  final List<User> users = [
    const User(
      id: 'user_1',
      name: 'Amina Hassan',
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      isOnline: true,
      bio: 'Product designer',
    ),
    const User(
      id: 'user_2',
      name: 'Kwame Mensah',
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      isOnline: false,
      lastSeen: null,
      bio: 'Software engineer',
    ),
    const User(
      id: 'user_3',
      name: 'Fatima Ali',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
      isOnline: true,
      bio: 'Marketing lead',
    ),
    const User(
      id: 'user_4',
      name: 'David Osei',
      avatarUrl: 'https://i.pravatar.cc/150?img=8',
      isOnline: false,
      bio: 'Data analyst',
    ),
    const User(
      id: 'user_5',
      name: 'Grace Adjei',
      avatarUrl: 'https://i.pravatar.cc/150?img=9',
      isOnline: true,
      bio: 'UX researcher',
    ),
    const User(
      id: 'user_6',
      name: 'Samuel Boateng',
      avatarUrl: 'https://i.pravatar.cc/150?img=11',
      isOnline: false,
      bio: 'DevOps engineer',
    ),
  ];

  late final List<Chat> chats = [
    Chat(
      id: 'chat_1',
      participantIds: [currentUserId, 'user_1'],
      lastMessage: 'See you at the meeting tomorrow!',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
      unreadCount: 2,
      isPinned: true,
    ),
    Chat(
      id: 'chat_2',
      participantIds: [currentUserId, 'user_2'],
      lastMessage: 'The API docs are ready for review.',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
      unreadCount: 0,
    ),
    Chat(
      id: 'chat_3',
      participantIds: [currentUserId, 'user_3'],
      lastMessage: 'Can you share the campaign assets?',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 3)),
      unreadCount: 1,
    ),
    Chat(
      id: 'chat_4',
      participantIds: [currentUserId, 'user_4', 'user_5', 'user_6'],
      lastMessage: 'Great work on the sprint demo!',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 0,
      isGroup: true,
      groupName: 'Project Alpha',
      groupAvatarUrl: 'https://i.pravatar.cc/150?img=20',
    ),
    Chat(
      id: 'chat_5',
      participantIds: [currentUserId, 'user_5'],
      lastMessage: 'Thanks for the feedback!',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
      unreadCount: 0,
    ),
  ];

  late final Map<String, List<Message>> messagesByChat = {
    'chat_1': [
      Message(
        id: 'msg_1',
        chatId: 'chat_1',
        senderId: 'user_1',
        content: 'Hey! How is the chat UI coming along?',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: true,
      ),
      Message(
        id: 'msg_2',
        chatId: 'chat_1',
        senderId: currentUserId,
        content: 'Going great! Material 3 theme is looking sharp.',
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
        isRead: true,
      ),
      Message(
        id: 'msg_3',
        chatId: 'chat_1',
        senderId: 'user_1',
        content: 'See you at the meeting tomorrow!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isRead: false,
      ),
    ],
    'chat_2': [
      Message(
        id: 'msg_4',
        chatId: 'chat_2',
        senderId: 'user_2',
        content: 'The API docs are ready for review.',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        isRead: true,
      ),
    ],
    'chat_3': [
      Message(
        id: 'msg_5',
        chatId: 'chat_3',
        senderId: 'user_3',
        content: 'Can you share the campaign assets?',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        isRead: false,
      ),
    ],
    'chat_4': [
      Message(
        id: 'msg_6',
        chatId: 'chat_4',
        senderId: 'user_6',
        content: 'Great work on the sprint demo!',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
    ],
    'chat_5': [
      Message(
        id: 'msg_7',
        chatId: 'chat_5',
        senderId: 'user_5',
        content: 'Thanks for the feedback!',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
      ),
    ],
  };

  late final List<ChatGroup> groups = [
    ChatGroup(
      id: 'group_1',
      name: 'Project Alpha',
      description: 'Core team collaboration channel',
      memberIds: [currentUserId, 'user_4', 'user_5', 'user_6'],
      avatarUrl: 'https://i.pravatar.cc/150?img=20',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    ChatGroup(
      id: 'group_2',
      name: 'Design Squad',
      description: 'UI/UX discussions and reviews',
      memberIds: [currentUserId, 'user_1', 'user_5'],
      avatarUrl: 'https://i.pravatar.cc/150?img=21',
      createdAt: DateTime.now().subtract(const Duration(days: 14)),
    ),
    ChatGroup(
      id: 'group_3',
      name: 'Weekend Plans',
      description: 'Social group for weekend activities',
      memberIds: [currentUserId, 'user_2', 'user_3', 'user_6'],
      avatarUrl: 'https://i.pravatar.cc/150?img=22',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];

  late final List<StatusUpdate> statuses = [
    StatusUpdate(
      id: 'status_1',
      userId: 'user_1',
      content: 'Working on new designs ✨',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      viewCount: 12,
    ),
    StatusUpdate(
      id: 'status_2',
      userId: 'user_3',
      content: 'Launch day! 🚀',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      viewCount: 28,
      isViewed: true,
    ),
    StatusUpdate(
      id: 'status_3',
      userId: 'user_5',
      content: 'Coffee break ☕',
      timestamp: DateTime.now().subtract(const Duration(hours: 8)),
      viewCount: 7,
    ),
  ];

  late final List<AppNotification> notifications = [
    AppNotification(
      id: 'notif_1',
      title: 'New message from Amina',
      body: 'See you at the meeting tomorrow!',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      relatedUserId: 'user_1',
      relatedChatId: 'chat_1',
    ),
    AppNotification(
      id: 'notif_2',
      title: 'Missed voice call',
      body: 'Kwame Mensah tried to call you',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      type: NotificationType.call,
      relatedUserId: 'user_2',
    ),
    AppNotification(
      id: 'notif_3',
      title: 'Added to group',
      body: 'You were added to Design Squad',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      type: NotificationType.group,
    ),
    AppNotification(
      id: 'notif_4',
      title: 'App update',
      body: 'Chat UI v1.0 is now available',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      type: NotificationType.system,
      isRead: true,
    ),
  ];

  User? getUserById(String id) {
    if (id == currentUserId) return currentUser;
    for (final user in users) {
      if (user.id == id) return user;
    }
    return null;
  }

  Chat? getChatById(String id) {
    for (final chat in chats) {
      if (chat.id == id) return chat;
    }
    return null;
  }

  List<Message> getMessagesForChat(String chatId) {
    return messagesByChat[chatId] ?? [];
  }

  String getChatDisplayName(Chat chat) {
    if (chat.isGroup && chat.groupName != null) {
      return chat.groupName!;
    }
    final otherId = chat.participantIds.firstWhere(
      (id) => id != currentUserId,
      orElse: () => chat.participantIds.first,
    );
    return getUserById(otherId)?.name ?? 'Unknown';
  }

  String getChatAvatarUrl(Chat chat) {
    if (chat.isGroup && chat.groupAvatarUrl != null) {
      return chat.groupAvatarUrl!;
    }
    final otherId = chat.participantIds.firstWhere(
      (id) => id != currentUserId,
      orElse: () => chat.participantIds.first,
    );
    return getUserById(otherId)?.avatarUrl ?? '';
  }

  User? getOtherParticipant(Chat chat) {
    if (chat.isGroup) return null;
    final otherId = chat.participantIds.firstWhere(
      (id) => id != currentUserId,
      orElse: () => '',
    );
    return getUserById(otherId);
  }

  void sendMessage(String chatId, String content) {
    final message = Message(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      chatId: chatId,
      senderId: currentUserId,
      content: content,
      timestamp: DateTime.now(),
      isRead: false,
      isSent: true,
    );
    messagesByChat.putIfAbsent(chatId, () => []).add(message);

    final chatIndex = chats.indexWhere((c) => c.id == chatId);
    if (chatIndex != -1) {
      final chat = chats[chatIndex];
      chats[chatIndex] = Chat(
        id: chat.id,
        participantIds: chat.participantIds,
        lastMessage: content,
        lastMessageTime: DateTime.now(),
        isPinned: chat.isPinned,
        unreadCount: chat.unreadCount,
        isGroup: chat.isGroup,
        groupName: chat.groupName,
        groupAvatarUrl: chat.groupAvatarUrl,
      );
    }
  }

  List<Chat> searchChats(String query) {
    if (query.isEmpty) return chats;
    final lower = query.toLowerCase();
    return chats.where((chat) {
      final name = getChatDisplayName(chat).toLowerCase();
      final message = chat.lastMessage.toLowerCase();
      return name.contains(lower) || message.contains(lower);
    }).toList();
  }

  int get unreadNotificationCount =>
      notifications.where((n) => !n.isRead).length;
}
