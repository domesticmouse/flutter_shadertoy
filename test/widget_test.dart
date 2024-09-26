import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shadertoy/main.dart';

void main() {
  testWidgets('Foud Hello, Shader smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        title: 'Shadertoy test',
        home: MyApp(),
      ),
    );

    // Verify that our app displays the text 'Hello, Shader'.
    expect(find.text('Hello, Shader'), findsOneWidget);
  });
}
