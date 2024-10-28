import 'package:flutter_test/flutter_test.dart';

int add(int a, int b) => a + b;


void main() {
  group('Manual Sync Test', () {
    test('Adding two positive numbers', () {
      expect(add(2, 3), 5);
    });

    test('Adding two negative numbers', () {
      expect(add(-2, -3), -5);
    });

    test('Adding a positive and a negative number', () {
      expect(add(2, -3), -1);
    });
  });
}



