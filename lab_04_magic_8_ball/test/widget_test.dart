import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_04_magic_8_ball/main.dart';

void main() {
  testWidgets('MagicBallApp builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MagicBallApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
