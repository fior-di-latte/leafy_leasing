import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leafy_leasing/app/app.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(Container(color: Colors.red));
      print('rofl');
      expect(find.byType(AppBar), findsOneWidget);
    });
  });
}
