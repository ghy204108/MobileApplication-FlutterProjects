import 'package:chapter3_practice/mainrestaurant.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('restaurant app shows food menu sections', (tester) async {
    await tester.pumpWidget(const RestaurantApp());

    expect(find.text('Food Menu'), findsOneWidget);
    expect(find.text('Category'), findsOneWidget);
    expect(find.text('Recommendation for Diet'), findsOneWidget);
    expect(find.text('Honey Pancake'), findsOneWidget);
  });
}
