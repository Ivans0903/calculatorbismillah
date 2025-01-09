import 'package:flutter_test/flutter_test.dart';

// Pastikan path import ini sesuai dengan lokasi file main.dart di proyekmu.
import 'package:calculatorbismillah/main.dart';

void main() {
  testWidgets('Calculator widget smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CalculatorApp()); // Pastikan nama widget sesuai dengan main.dart

    // Verify that our calculator starts with empty input.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Optional: Add interaction test like pressing buttons and verifying results.
    await tester.tap(find.text('1'));
    await tester.tap(find.text('+'));
    await tester.tap(find.text('2'));
    await tester.tap(find.text('='));
    await tester.pump();

    // Verify that the result shows '3'.
    expect(find.text('3'), findsOneWidget);
  });
}
