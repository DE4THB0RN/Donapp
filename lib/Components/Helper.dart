import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt_decrypt_plus/cipher/cipher.dart';

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

final Cipher cipher = Cipher();
