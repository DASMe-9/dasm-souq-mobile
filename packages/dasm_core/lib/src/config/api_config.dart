class ApiConfig {
  final String baseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;

  const ApiConfig({
    required this.baseUrl,
    this.connectTimeout = const Duration(seconds: 15),
    this.receiveTimeout = const Duration(seconds: 30),
  });

  static const production = ApiConfig(
    baseUrl: 'https://api.dasm.com.sa/api',
  );

  static const staging = ApiConfig(
    baseUrl: 'https://api.dasm.com.sa/api',
  );
}
