import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_09_clima/main.dart';

void main() {
  testWidgets('ClimaApp builds', (WidgetTester tester) async {
    await tester.pumpWidget(const ClimaApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
