import 'package:chapter8_practice_firebase/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows Firebase setup screen when configuration is missing', (
    tester,
  ) async {
    await tester.pumpWidget(
      const NotesApp(startup: FirebaseStartup.failed('missing config')),
    );

    expect(find.text('Firebase Notes'), findsOneWidget);
    expect(find.text('Firebase setup required'), findsOneWidget);
    expect(find.text('com.example.chapter8_practice_firebase'), findsOneWidget);
  });
}
