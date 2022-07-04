import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart' as crypto;

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

String getRandomNumber() {
  final num = List.generate(8, (_) => (_rnd).nextInt(9)).join();
  return '+49152$num';
}

extension HashString on String {
  String md5() {
    return crypto.md5.convert(utf8.encode(this)).toString();
  }
}
