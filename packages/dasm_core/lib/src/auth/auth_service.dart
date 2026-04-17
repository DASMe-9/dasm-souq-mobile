import 'package:dio/dio.dart';

import '../api/api_client.dart';
import 'token_storage.dart';

class AuthService {
  final ApiClient _api;
  final TokenStorage _tokens;

  AuthService({required ApiClient api, required TokenStorage tokens})
      : _api = api,
        _tokens = tokens;

  Future<bool> isAuthenticated() async {
    final token = await _tokens.read();
    return token != null && token.isNotEmpty;
  }

  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _api.dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      final token = res.data['access_token'] as String?;
      if (token == null || token.isEmpty) {
        return AuthResult.failure('استجابة غير صالحة من الخادم');
      }
      await _tokens.write(token);
      return AuthResult.success(token);
    } on DioException catch (e) {
      final msg = e.response?.data is Map
          ? (e.response!.data['message']?.toString() ?? 'فشل تسجيل الدخول')
          : 'فشل تسجيل الدخول';
      return AuthResult.failure(msg);
    } catch (_) {
      return AuthResult.failure('خطأ غير متوقع');
    }
  }

  Future<void> logout() async {
    try {
      await _api.dio.post('/logout');
    } catch (_) {
    } finally {
      await _tokens.clear();
    }
  }
}

class AuthResult {
  final bool ok;
  final String? token;
  final String? error;

  const AuthResult._({required this.ok, this.token, this.error});

  factory AuthResult.success(String token) =>
      AuthResult._(ok: true, token: token);

  factory AuthResult.failure(String error) =>
      AuthResult._(ok: false, error: error);
}
