import 'dart:math';

import 'package:crypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:test/test.dart';

void main() {
  const message = 'This is a test message';
  const messageSpec = r'This is a test message with special characters: &%$#@!';

  group('RSAEncryptor', () {
    test('should correctly encrypt and decrypt message', () {
      final decryptor = RSADecryptor();
      final publicKey = decryptor.publicKeyString;
      final encryptor = RSAEncryptor(publicKey);

      final encrypted = encryptor.encrypt(message);
      final decrypted = decryptor.decrypt(encrypted!);

      expect(decrypted, message);
    });

    test('invalid key should throw FormatException', () {
      expect(() => RSAEncryptor('invalid key'), throwsFormatException);
    });

    test('should return null on encrypting message that is too long', () {
      final decryptor = RSADecryptor();
      final publicKey = decryptor.publicKeyString;
      final encryptor = RSAEncryptor(publicKey);

      final message = String.fromCharCodes(
        List.generate(201, (_) => Random().nextInt(128)),
      );
      final encrypted = encryptor.encrypt(message);
      expect(encrypted, isNull);
    });

    test('should correctly encrypt and decrypt special characters', () {
      final decryptor = RSADecryptor();
      final publicKey = decryptor.publicKeyString;
      final encryptor = RSAEncryptor(publicKey);

      final encrypted = encryptor.encrypt(messageSpec);
      final decrypted = decryptor.decrypt(encrypted!);
      expect(decrypted, messageSpec);
    });

    test('should correctly encode public key to PEM format', () {
      final publicKey = RSAPublicKey(BigInt.from(3), BigInt.from(65537));
      const expectedPem = 'MBwwDQYJKoZIhvcNAQEBBQADCwAwCAIBAwIDAQAB';
      final pem = RSAEncryptor.encodeRSAPublicKeyToPem(publicKey);
      expect(pem, expectedPem);
    });
  });
}
