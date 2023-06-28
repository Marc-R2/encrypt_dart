// This file works with test_builder
// @MarcR2 (Marc Renken) - https://github.com/MarcR2/test_builder

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
    final handlerA = ECCHandler();
    final handlerB = ECCHandler();
    test('encryptTest same', () {
      const data = 'encryptTest';
      final encrypted = handlerA.encrypt(data: data, key: handlerA.publicKey);
      expect(encrypted, isNot(data));
      final decrypted =
          handlerA.decrypt(data: encrypted, key: handlerA.publicKey);
      expect(decrypted, data);
    });

    test('encryptTest other', () {
      const data = 'encryptTest';
      final encrypted = handlerA.encrypt(data: data, key: handlerB.publicKey);
      expect(encrypted, isNot(data));
      final decrypted =
          handlerB.decrypt(data: encrypted, key: handlerA.publicKey);
      expect(decrypted, data);
    });
  }

  @override
  void decryptTest() {
    // TODO: Implement tests
    test('decryptTest', () {});
  }
}
