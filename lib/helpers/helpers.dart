// helpers.dart
import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart' as crypto;

class Helpers {
  static String aesDecrypt(String base64Data, String password) {
    var decryptedData = '';
    try {
      const method = encrypt.AESMode.cbc;

      final key = crypto.sha256.convert(utf8.encode(password)).bytes;
      final data = base64.decode(base64Data);
      final iv = encrypt.IV(data.sublist(0, 16));
      final encryptedData = data.sublist(16);
      final encrypter = encrypt.Encrypter(encrypt.AES(
          encrypt.Key.fromBase16(
              key.map((e) => e.toRadixString(16).padLeft(2, '0')).join()),
          mode: method));
      decryptedData =
          encrypter.decrypt(encrypt.Encrypted(encryptedData), iv: iv);

      return decryptedData;
    } catch (e) {
      return decryptedData;
    }
  }
}
