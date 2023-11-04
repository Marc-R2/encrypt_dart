// This file works with test_builder
// @MarcR2 (Marc Renken) - https://github.com/MarcR2/test_builder

import 'dart:typed_data';

import 'package:crypt/encrypt.dart';
import 'package:log_message/logger.dart';
import 'package:test_builder/test_builder.dart';
import '../../../../.testGen/source/src/RSA/r_s_a_encryptor.test_gen.dart';

void main() {
  RSAEncryptorTest();
}

class RSAEncryptorTest extends RSAEncryptorTestTop with Logging {
  @override
  void decryptTest() {
    final log = functionStart('decryptTest');

    final encryptor = RSAEncryptor.fromKey(null, null);

    test('decrypt should throw', () {
      expect(
        () => encryptor.decrypt(data: '', context: log),
        throwsA(isA<ErrorMessage>()),
      );
    });
  }

  @override
  void decryptBinaryTest() {
    final log = functionStart('decryptBinaryTest');

    final encryptor = RSAEncryptor.fromKey(null, null);

    test('decryptBinary should throw', () {
      expect(
        () => encryptor.decryptBinary(data: Uint8List(0), context: log),
        throwsA(isA<ErrorMessage>()),
      );
    });
  }
}
