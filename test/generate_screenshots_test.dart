import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:chat_ui/core/theme/app_theme.dart';
import 'package:chat_ui/screens/onboarding/onboarding_screen.dart';
import 'package:chat_ui/screens/login/login_screen.dart';
import 'package:chat_ui/screens/chats/chats_screen.dart';
import 'package:chat_ui/screens/conversation/conversation_screen.dart';
import 'package:chat_ui/screens/calls/voice_call_screen.dart';
import 'package:chat_ui/screens/calls/video_call_screen.dart';
import 'package:chat_ui/screens/groups/groups_screen.dart';
import 'package:chat_ui/screens/status/status_screen.dart';
import 'package:chat_ui/screens/contacts/contacts_screen.dart';
import 'package:chat_ui/screens/profile/profile_screen.dart';
import 'package:chat_ui/screens/settings/settings_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets('Generate high-res screenshots for Chat UI App', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;

    final screens = <String, Widget>{
      '01_onboarding': const ChatOnboardingScreen(),
      '02_login': const LoginScreen(),
      '03_chats': const ChatsScreen(),
      '04_conversation': const ConversationScreen(chatId: '1'),
      '05_voice_call': const VoiceCallScreen(userId: '1'),
      '06_video_call': const VideoCallScreen(userId: '1'),
      '07_groups': const GroupsScreen(),
      '08_status': const StatusScreen(),
      '09_contacts': const ContactsScreen(),
      '10_profile': const ProfileScreen(),
      '11_settings': const SettingsScreen(),
    };

    final dir = Directory('screenshots');
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    for (final entry in screens.entries) {
      final repaintBoundaryKey = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          home: RepaintBoundary(
            key: repaintBoundaryKey,
            child: entry.value,
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final boundary = repaintBoundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary != null) {
        await tester.runAsync(() async {
          final image = await boundary.toImage(pixelRatio: 2.0);
          final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
          if (byteData != null) {
            final pngBytes = byteData.buffer.asUint8List();
            final file = File('screenshots/${entry.key}.png');
            await file.writeAsBytes(pngBytes);
            // ignore: avoid_print
            print('Saved screenshot: screenshots/${entry.key}.png (${pngBytes.length} bytes)');
          }
        });
      }
    }
  });
}
