import 'dart:math';

import 'package:crypt/encrypt.dart';
import 'package:log_message/logger.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:test/test.dart';

import '../../../lib/play.dart';

void main() {
  const message = 'This is a test message';
  const messageSpec = r'This is a test message with special characters: &%$#@!';

  group('RSAEncryptor', () {
    test('should correctly encrypt and decrypt message', () {
      TimeDebugger.marker('0');
      final decryptor = RSADecryptor();
      TimeDebugger.marker('1');
      final publicKey = decryptor.publicKeyString;
      TimeDebugger.marker('2');
      final encryptor = RSAEncryptor(publicKey);
      TimeDebugger.marker('3');
      final encrypted = encryptor.encrypt(data: message);
      TimeDebugger.marker('4');
      final decrypted = decryptor.decrypt(data: encrypted);
      TimeDebugger.marker('5');
      expect(decrypted, message);
    });

    test('invalid key should throw FormatException', () {
      expect(() => RSAEncryptor('invalid key'), throwsFormatException);
    });

    test('should return throws on encrypting message that is too long', () {
      final decryptor = RSADecryptor();
      final publicKey = decryptor.publicKeyString;
      final encryptor = RSAEncryptor(publicKey);

      final message = String.fromCharCodes(
        List.generate(201, (_) => Random().nextInt(128)),
      );
      expect(
        () => encryptor.encrypt(data: message),
        throwsA(isA<ErrorMessage>()),
      );
    });

    test('should correctly encrypt and decrypt special characters', () {
      final decryptor = RSADecryptor();
      final publicKey = decryptor.publicKeyString;
      final encryptor = RSAEncryptor(publicKey);

      final encrypted = encryptor.encrypt(data: messageSpec);
      final decrypted = decryptor.decrypt(data: encrypted);
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
