import 'dart:math';

import 'package:crypt/encrypt.dart';
import 'package:log_message/logger.dart';
import 'package:test/test.dart';

void main() {
  const message = 'This is a test message';
  const invalidMessage = 'This is not a valid encrypted message';
  const messageSpec = r'This is a test message with special characters: &%$#@!';
  final decryptor = RSADecryptor();

  group('RSADecryptor', () {
    test('should correctly encrypt and decrypt message', () {
      final encrypted = decryptor.encrypt(data: message);
      final decrypted = decryptor.decrypt(data: encrypted);
      expect(decrypted, message);
    });

    test('should throw on decrypting invalid message', () {
      final decryptor = RSADecryptor();
      ;
      expect(
        () => decryptor.decrypt(data: invalidMessage),
        throwsA(isA<ErrorMessage>()),
      );
    });

    test('should generate new key pair on construction', () {
      final decryptor2 = RSADecryptor();
      expect(decryptor.publicKeyString, isNot(decryptor2.publicKeyString));
    });

    test('should correctly decrypt message encrypted with public key', () {
      final encryptor = RSAEncryptor(decryptor.publicKeyString);

      final encrypted = encryptor.encrypt(data: message);
      final decrypted = decryptor.decrypt(data: encrypted);

      expect(decrypted, message);
    });

    test('should correctly encrypt and decrypt long message', () {
      final message = String.fromCharCodes(
        List.generate(200, (_) => Random().nextInt(128)),
      );

      final encrypted = decryptor.encrypt(data: message);
      final decrypted = decryptor.decrypt(data: encrypted);
      expect(decrypted, message);
    });

    test('should correctly encrypt and decrypt special characters', () {
      final encrypted = decryptor.encrypt(data: messageSpec);
      final decrypted = decryptor.decrypt(data: encrypted);
      expect(decrypted, messageSpec);
    });

    test('should correctly encrypt and decrypt message with different key pair',
        () {
      final decryptor1 = RSADecryptor();
      final decryptor2 = RSADecryptor();

      final encryptor1 = RSAEncryptor(decryptor1.publicKeyString);
      final encryptor2 = RSAEncryptor(decryptor2.publicKeyString);

      final encrypted1 = encryptor1.encrypt(data: message);
      final encrypted2 = encryptor2.encrypt(data: message);

      final decrypted1 = decryptor1.decrypt(data: encrypted1);
      final decrypted2 = decryptor2.decrypt(data: encrypted2);

      expect(decrypted1, message);
      expect(decrypted2, message);
    });

    test('should produce different encrypted messages with different keys', () {
      final decryptor1 = RSADecryptor();
      final decryptor2 = RSADecryptor();

      final encryptor1 = RSAEncryptor(decryptor1.publicKeyString);
      final encryptor2 = RSAEncryptor(decryptor2.publicKeyString);

      final encrypted1 = encryptor1.encrypt(data: message);
      final encrypted2 = encryptor2.encrypt(data: message);

      expect(encrypted1, isNot(encrypted2));
      expect(decryptor1.publicKeyString, isNot(decryptor2.publicKeyString));
    });

    test('should produce different encrypted messages with different keys', () {
      final decryptor1 = RSADecryptor();
      final decryptor2 = RSADecryptor();

      final encrypted1 = decryptor1.encrypt(data: message);
      final encrypted2 = decryptor2.encrypt(data: message);

      expect(encrypted1, isNot(encrypted2));
      expect(decryptor1.publicKeyString, isNot(decryptor2.publicKeyString));
    });

    test('should correctly encrypt and decrypt message with spaces', () {
      const message = 'This is a test message with spaces';
      final encrypted = decryptor.encrypt(data: message);
      final decrypted = decryptor.decrypt(data: encrypted);
      expect(decrypted, message);
    });

    test(
      'should correctly encrypt and decrypt message with '
      'leading and trailing whitespace',
      () {
        const message = '  This is a test message with '
            'leading and trailing whitespace   ';
        final encrypted = decryptor.encrypt(data: message);
        final decrypted = decryptor.decrypt(data: encrypted);
        expect(decrypted, message);
      },
    );

    test(
      'should throw on decrypting message '
      'encrypted with different (invalid) key',
      () {
        final encryptor = RSADecryptor();
        final encrypted = encryptor.encrypt(data: message);
        expect(
          () => decryptor.decrypt(data: encrypted),
          throwsA(isA<ErrorMessage>()),
        );
      },
    );

    test(
      'should return null on decrypting message '
      'encrypted with different algorithm',
      () {
        const encrypted = 'This is not a valid encrypted message';
        expect(
          () => decryptor.decrypt(data: encrypted),
          throwsA(isA<ErrorMessage>()),
        );
      },
    );

    test('should use 2048-bit keys', () {
      final keyLength = decryptor.publicKey.modulus?.bitLength;
      expect(keyLength, 2048);
    });
  });
}
