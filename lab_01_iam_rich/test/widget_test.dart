import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_01_iam_rich/main.dart';

void main() {
  testWidgets('RichApp builds', (WidgetTester tester) async {
    await tester.pumpWidget(const RichApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
