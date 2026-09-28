import 'package:chat_ui/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Chat UI app renders splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ChatApp());
    await tester.pump();

    expect(find.text('Chat UI'), findsOneWidget);
    expect(find.text('Connect. Chat. Share.'), findsOneWidget);
  });
}
