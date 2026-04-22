import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_08_bmi_calculator/main.dart';

void main() {
  testWidgets('BmiApp builds', (WidgetTester tester) async {
    await tester.pumpWidget(const BmiApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
