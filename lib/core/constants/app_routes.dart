class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String chats = '/chats';
  static const String conversation = '/conversation/:chatId';
  static const String voiceCall = '/voice-call/:userId';
  static const String videoCall = '/video-call/:userId';
  static const String contacts = '/contacts';
  static const String groups = '/groups';
  static const String status = '/status';
  static const String search = '/search';
  static const String notifications = '/notifications';
  static const String profile = '/profile';
  static const String settings = '/settings';

  static String conversationPath(String chatId) => '/conversation/$chatId';
  static String voiceCallPath(String userId) => '/voice-call/$userId';
  static String videoCallPath(String userId) => '/video-call/$userId';
}
