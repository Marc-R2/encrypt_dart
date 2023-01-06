// AES
import 'AES/aes_encrypter_test.dart' as aes_encrypter;
import 'AES/aes_handler_test.dart' as aes_handler;

// RSA
import 'package:crypt/encrypt.dart';
import 'package:test/test.dart';

import 'RSA/rsa_decryptor_test.dart' as rsa_decryptor;
import 'RSA/rsa_encryption_handler_test.dart' as rsa_encryption_handler;
import 'RSA/rsa_encryptor_test.dart' as rsa_encryptor;

import 'hash_test.dart' as hash;

Future<void> main() async {
  // AES
  aes_encrypter.main();
  aes_handler.main();

  // RSA
  rsa_encryptor.main();
  rsa_decryptor.main();
  rsa_encryption_handler.main();

  // Hash
  await hash.main();

  group('Encrypt', () {
    final key = Encrypt.publicKey;

    test('should correctly encrypt and decrypt message', () {
      const message = 'This is a test message';
      final encrypted = Encrypt.encrypt(data: message, key: key);
      final decrypted = Encrypt.decrypt(data: encrypted!);
      expect(decrypted, message);
      expect(encrypted.length, 2);
    });

    test('should return null on decrypting invalid message', () {
      final invalidMessage = ['This is not a valid encrypted message'];
      final decrypted = Encrypt.decrypt(data: invalidMessage);
      expect(decrypted, isNull);
    });
  });
}
