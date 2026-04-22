import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_05_xylophone/main.dart';

void main() {
  testWidgets('XylophoneApp builds', (WidgetTester tester) async {
    await tester.pumpWidget(const XylophoneApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
