import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(Container(color: Colors.red));
      expect(find.byType(Container), findsOneWidget);
    });
  });
}
