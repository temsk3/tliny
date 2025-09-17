import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

class Security {
  Security()
    : _encrypter = Encrypter(
        AES(Key.fromUtf8(dotenv.get('KEY')), mode: AESMode.cbc),
      );

  final _logger = Logger();
  final Encrypter _encrypter;

  String encrypt(String eventId, String uuid, bool isPdf) {
    final prefix = isPdf ? 'PDF' : 'REG';
    final data = '$prefix|$eventId|$uuid';
    _logger.d('Data to encrypt: $data');

    final iv = IV.fromLength(16); // Generate a new IV for each encryption
    final encrypted = _encrypter.encrypt(data, iv: iv);

    final encryptedWithIv =
        iv.base64 + encrypted.base64; // Prepend IV to the encrypted data
    _logger.d('Encrypted with IV: $encryptedWithIv');
    return encryptedWithIv;
  }

  String decrypt(String encryptedWithIv) {
    _logger.d('Encrypted data with IV: $encryptedWithIv');

    final iv = IV.fromBase64(
      encryptedWithIv.substring(0, 24),
    ); // Extract the IV
    final encrypted = Encrypted.fromBase64(
      encryptedWithIv.substring(24),
    ); // Extract the encrypted data

    final decrypted = _encrypter.decrypt(encrypted, iv: iv);
    _logger.d('Decrypted data: $decrypted');
    return decrypted; // "PDF|eventID|uuid" または "REG|eventID|uuid"
  }
}
