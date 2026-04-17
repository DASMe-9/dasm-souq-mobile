import 'package:dasm_core/dasm_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ApiConfig production points to DASM API', () {
    expect(ApiConfig.production.baseUrl, 'https://api.dasm.com.sa/api');
  });

  test('DasmColors primary is DASM blue', () {
    expect(DasmColors.primary, const Color(0xFF1F4B7A));
  });

  test('DasmColors accent is DASM green', () {
    expect(DasmColors.accent, const Color(0xFF009345));
  });
}
