import 'package:get_it/get_it.dart';

import '../api/api_client.dart';
import '../auth/auth_service.dart';
import '../auth/token_storage.dart';
import '../config/api_config.dart';

final GetIt locator = GetIt.instance;

Future<void> setupDasmCore({ApiConfig? config}) async {
  final apiConfig = config ?? ApiConfig.production;

  if (!locator.isRegistered<TokenStorage>()) {
    locator.registerLazySingleton<TokenStorage>(() => TokenStorage());
  }
  if (!locator.isRegistered<ApiClient>()) {
    locator.registerLazySingleton<ApiClient>(
      () => ApiClient(config: apiConfig, tokens: locator<TokenStorage>()),
    );
  }
  if (!locator.isRegistered<AuthService>()) {
    locator.registerLazySingleton<AuthService>(
      () => AuthService(
        api: locator<ApiClient>(),
        tokens: locator<TokenStorage>(),
      ),
    );
  }
}
