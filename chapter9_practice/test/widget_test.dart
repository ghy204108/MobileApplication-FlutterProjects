import 'package:chapter9_practice/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows KL Landmark Explorer title', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('KL Landmark Explorer'), findsOneWidget);
  });
}
