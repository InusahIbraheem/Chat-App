import 'package:go_router/go_router.dart';

import '../core/constants/app_routes.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/calls/video_call_screen.dart';
import '../screens/calls/voice_call_screen.dart';
import '../screens/chats/chats_screen.dart';
import '../screens/contacts/contacts_screen.dart';
import '../screens/conversation/conversation_screen.dart';
import '../screens/groups/groups_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/notifications/notifications_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/status/status_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.onboarding,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const ChatOnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.chats,
        builder: (context, state) => const ChatsScreen(),
      ),
      GoRoute(
        path: AppRoutes.conversation,
        builder: (context, state) {
          final chatId = state.pathParameters['chatId']!;
          return ConversationScreen(chatId: chatId);
        },
      ),
      GoRoute(
        path: AppRoutes.voiceCall,
        builder: (context, state) {
          final userId = state.pathParameters['userId']!;
          return VoiceCallScreen(userId: userId);
        },
      ),
      GoRoute(
        path: AppRoutes.videoCall,
        builder: (context, state) {
          final userId = state.pathParameters['userId']!;
          return VideoCallScreen(userId: userId);
        },
      ),
      GoRoute(
        path: AppRoutes.contacts,
        builder: (context, state) => const ContactsScreen(),
      ),
      GoRoute(
        path: AppRoutes.groups,
        builder: (context, state) => const GroupsScreen(),
      ),
      GoRoute(
        path: AppRoutes.status,
        builder: (context, state) => const StatusScreen(),
      ),
      GoRoute(
        path: AppRoutes.search,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
