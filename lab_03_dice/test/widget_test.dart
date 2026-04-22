import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_03_dice/main.dart';

void main() {
  testWidgets('DiceApp builds', (WidgetTester tester) async {
    await tester.pumpWidget(const DiceApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
