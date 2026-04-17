import 'package:flutter_test/flutter_test.dart';
import 'package:dasm_core/dasm_core.dart';

void main() {
  test('ApiConfig production points to DASM api', () {
    expect(ApiConfig.production.baseUrl, 'https://api.dasm.com.sa/api');
  });
}
