import 'package:catalog_app_flutter/core/utils/math_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  
  group('add', () {
    test('add 1 + 1 = 2', () {
      expect(add(1, 1), 2);
    });
    test('add -2 + 1', () {
      expect(add(-2, 1), -1);
    });
  });
  
}
