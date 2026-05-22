import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mandionline/configs/components/primary_button.dart';

void main() {
  testWidgets('PrimaryButton shows label', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(label: 'Go', onPressed: () {}),
        ),
      ),
    );
    expect(find.text('Go'), findsOneWidget);
  });
}
