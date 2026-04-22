import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_02_micard/main.dart';

void main() {
  testWidgets('MiCardApp builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MiCardApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
