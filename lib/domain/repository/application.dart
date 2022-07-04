import 'dart:ui';

abstract class ApplicationRepository {
  Future<Locale> getLocal();

  Future<Locale> initializeLocale(Locale defaultLocale);

  Future<dynamic> initDatabase();

  Future<void> initNetwork();

  Future<void> dispose();
}
