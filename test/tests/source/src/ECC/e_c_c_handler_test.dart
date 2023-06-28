// This file works with test_builder
// @MarcR2 (Marc Renken) - https://github.com/MarcR2/test_builder

import 'dart:math';

import 'package:crypt/encrypt.dart';
import 'package:test_builder/test_builder.dart';
import '../../../../.testGen/source/src/ECC/e_c_c_handler.test_gen.dart';

void main() {
  ECCHandlerTest();
}

class ECCHandlerTest extends ECCHandlerTestTop {
  @override
  void publicKeyTest() {
    final handler = ECCHandler();
    test('publicKeyTest', () {
      expect(handler.publicKey, handler.session.publicKeyString);
      expect(handler.publicKey, hasLength(greaterThan(100)));
    });
  }

  @override
  void encryptTest() {
    final A = ECCHandler();
    final B = ECCHandler();
    test('encryptTest same', () {
      const data = 'encryptTest';
      final encrypted = A.encrypt(data: data, key: A.publicKey);
      expect(encrypted, isNot(data));
      final decrypted = A.decrypt(data: encrypted, key: A.publicKey);
      expect(decrypted, data);
    });

    test('encryptTest other', () {
      const data = 'encryptTest';
      final encrypted = A.encrypt(data: data, key: B.publicKey);
      expect(encrypted, isNot(data));
      final decrypted = B.decrypt(data: encrypted, key: A.publicKey);
      expect(decrypted, data);
    });

    test('test different lengths of data', () {
      for (var i = 1; i < 4096; i++) {
        final data = String.fromCharCodes(
          List.generate(i, (_) => Random().nextInt(256)),
        );
        final encrypted = A.encrypt(data: data, key: B.publicKey);
        expect(encrypted, isNot(data));
        final decrypted = B.decrypt(data: encrypted, key: A.publicKey);
        expect(decrypted, data);
      }
    });
  }

  @override
  void decryptTest() {
    // TODO: Implement tests
    test('decryptTest', () {});
  }
}
