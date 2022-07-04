final kAnimationDuration = Duration(milliseconds: 400);

class Constants {
  const Constants._();

  static const int kOtpLength = 6;

  static const int minPasswordLength = 8;
  static const int minUsernameLength = 6;

  static const String defaultFont = 'Wavehaus';
  static const String defaultIconFont = 'LineAwesome';

  static const String defaultLocal = 'de';

  static const String token = 'com.kreiosoft.moove.token';
  static const String locale = 'com.kreiosoft.moove.locale';
  static const String lastLoginAttempt = 'com.kreiosoft.moove.lastLoginAttempt';

  static const String passwordPatter = r'(?=.*?[#?!@$%^&*-])';
  static const String usernamePatter =
      r'^(?=[a-zA-Z0-9._]{6,20}$)(?!.*[_.]{2})[^_.].*[^_.]$';
}
