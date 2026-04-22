import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_07_destini/main.dart';

void main() {
  testWidgets('DestiniApp builds', (WidgetTester tester) async {
    await tester.pumpWidget(const DestiniApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
