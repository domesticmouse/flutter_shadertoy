import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shadertoy/main.dart';

void main() {
  testWidgets('AppBar presence', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        title: 'Shadertoy test',
        home: MyApp(),
      ),
    );

    // Verify that our app has an AppBar.
    expect(find.text('Shader Gallery'), findsOneWidget);
  });
}
