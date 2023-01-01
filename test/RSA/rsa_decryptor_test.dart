import 'dart:math';

import 'package:encrypt_dart/encrypt.dart';
import 'package:test/test.dart';

void main() {
  const message = 'This is a test message';
  const invalidMessage = 'This is not a valid encrypted message';
  const messageSpec = r'This is a test message with special characters: &%$#@!';

  group('RSADecryptor', () {
    test('should correctly encrypt and decrypt message', () {
      final decryptor = RSADecryptor();
      final encrypted = decryptor.encrypt(message);
      final decrypted = decryptor.decrypt(encrypted!);
      expect(decrypted, message);
    });

    test('should return null on decrypting invalid message', () {
      final decryptor = RSADecryptor();
      final decrypted = decryptor.decrypt(invalidMessage);
      expect(decrypted, isNull);
    });

    test('should generate new key pair on construction', () {
      final decryptor = RSADecryptor();
      final decryptor2 = RSADecryptor();
      expect(decryptor.publicKeyString, isNot(decryptor2.publicKeyString));
    });

    test('should correctly decrypt message encrypted with public key', () {
      final decryptor = RSADecryptor();
      final encryptor = RSAEncryptor(decryptor.publicKeyString);

      final encrypted = encryptor.encrypt(message);
      final decrypted = decryptor.decrypt(encrypted!);

      expect(decrypted, message);
    });

    test('should correctly encrypt and decrypt long message', () {
      final decryptor = RSADecryptor();
      final message = String.fromCharCodes(
        List.generate(200, (_) => Random().nextInt(128)),
      );

      final encrypted = decryptor.encrypt(message);
      final decrypted = decryptor.decrypt(encrypted!);
      expect(decrypted, message);
    });

    test('should correctly encrypt and decrypt special characters', () {
      final decryptor = RSADecryptor();
      final encrypted = decryptor.encrypt(messageSpec);
      final decrypted = decryptor.decrypt(encrypted!);
      expect(decrypted, messageSpec);
    });

    test('should correctly encrypt and decrypt message with different key pair', () {
      final decryptor1 = RSADecryptor();
      final decryptor2 = RSADecryptor();

      final encryptor1 = RSAEncryptor(decryptor1.publicKeyString);
      final encryptor2 = RSAEncryptor(decryptor2.publicKeyString);

      final encrypted1 = encryptor1.encrypt(message);
      final encrypted2 = encryptor2.encrypt(message);

      final decrypted1 = decryptor1.decrypt(encrypted1!);
      final decrypted2 = decryptor2.decrypt(encrypted2!);

      expect(decrypted1, message);
      expect(decrypted2, message);
    });

    test('should produce different encrypted messages with different keys', () {
      final decryptor1 = RSADecryptor();
      final decryptor2 = RSADecryptor();

      final encryptor1 = RSAEncryptor(decryptor1.publicKeyString);
      final encryptor2 = RSAEncryptor(decryptor2.publicKeyString);

      final encrypted1 = encryptor1.encrypt(message);
      final encrypted2 = encryptor2.encrypt(message);

      expect(encrypted1, isNot(encrypted2));
      expect(decryptor1.publicKeyString, isNot(decryptor2.publicKeyString));
    });

    test('should produce different encrypted messages with different keys', () {
      final decryptor1 = RSADecryptor();
      final decryptor2 = RSADecryptor();

      final encrypted1 = decryptor1.encrypt(message);
      final encrypted2 = decryptor2.encrypt(message);

      expect(encrypted1, isNot(encrypted2));
      expect(decryptor1.publicKeyString, isNot(decryptor2.publicKeyString));
    });

    test('should correctly encrypt and decrypt message with spaces', () {
      final decryptor = RSADecryptor();
      final message = 'This is a test message with spaces';
      final encrypted = decryptor.encrypt(message);
      final decrypted = decryptor.decrypt(encrypted!);
      expect(decrypted, message);
    });

    test('should correctly encrypt and decrypt message with leading and trailing whitespace', () {
      final decryptor = RSADecryptor();
      final message = '  This is a test message with leading and trailing whitespace   ';
      final encrypted = decryptor.encrypt(message);
      final decrypted = decryptor.decrypt(encrypted!);
      expect(decrypted, message);
    });

    test('should return null on decrypting message encrypted with different key', () {
      final decryptor = RSADecryptor();
      final encryptor = RSADecryptor();
      final encrypted = encryptor.encrypt(message);
      final decrypted = decryptor.decrypt(encrypted!);
      expect(decrypted, isNull);
    });

    test('should return null on decrypting message encrypted with different algorithm', () {
      final decryptor = RSADecryptor();
      final encrypted = 'This is not a valid encrypted message';
      final decrypted = decryptor.decrypt(encrypted);
      expect(decrypted, isNull);
    });

  });
}
