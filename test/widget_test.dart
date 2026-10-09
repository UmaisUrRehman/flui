import 'package:flutter_test/flutter_test.dart';
import 'package:uilearning/main.dart';

void main() {
  testWidgets('Flutter UI Mastery app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FlutterUIMasteryApp());

    // Verify that the app title is displayed.
    expect(find.text('Flutter UI Mastery'), findsWidgets);

    // Verify that core widget titles exist in the list.
    expect(find.text('Container'), findsWidgets);
    expect(find.text('Row'), findsWidgets);
    expect(find.text('Column'), findsWidgets);
  });
}
