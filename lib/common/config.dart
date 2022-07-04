class Config {
  final bool debug;
  final bool debugApiClient;
  final bool debugShowCheckedModeBanner;

  final String db;

  final String title;
  final String apiBaseUrl;
  final String wsUrl;
  final String policyUrl;
  final String appStoreUrl;
  final String playStoreUrl;

  final String googleMapApiKey;

  final String? proxyBaseUrl;

  const Config({
    required this.debug,
    required this.debugApiClient,
    required this.debugShowCheckedModeBanner,
    required this.db,
    required this.title,
    required this.apiBaseUrl,
    required this.wsUrl,
    required this.policyUrl,
    required this.appStoreUrl,
    required this.playStoreUrl,
    required this.googleMapApiKey,
    this.proxyBaseUrl,
  });
}
