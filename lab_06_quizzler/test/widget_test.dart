import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_06_quizzler/main.dart';

void main() {
  testWidgets('QuizzlerApp builds', (WidgetTester tester) async {
    await tester.pumpWidget(const QuizzlerApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
