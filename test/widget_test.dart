import 'package:flutter_test/flutter_test.dart';

import 'package:safezone/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SafeZoneApp());

    // Verify that the splash screen text exists
    expect(find.text('Safe'), findsOneWidget);
  });
}
