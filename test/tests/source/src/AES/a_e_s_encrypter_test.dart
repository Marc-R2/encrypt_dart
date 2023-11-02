// This file works with test_builder
// @MarcR2 (Marc Renken) - https://github.com/MarcR2/test_builder

import 'package:crypt/encrypt.dart';
import 'package:test_builder/test_builder.dart';
import '../../../../.testGen/source/src/AES/a_e_s_encrypter.test_gen.dart';

void main() {
  AESEncrypterTest();
}

class AESEncrypterTest extends AESEncrypterTestTop {
  static const key = 'abcdefghijklmnopq-:-rstuvwxyz0123456789';

  @override
  void constructorTest() {
    // TODO: Implement tests
  }

  @override
  void constructor_withKeyTest() {
    // TODO: Implement tests
  }

  @override
  void keyFromSecretTest() {
    // TODO: Implement tests
  }

  @override
  void encryptTest() {
    encryptDecryptTest();
  }

  @override
  void encryptBinaryTest() {
    // TODO: Implement tests
  }

  @override
  void decryptTest() {
    // TODO: Implement tests
  }

  @override
  void decryptBinaryTest() {
    // TODO: Implement tests
  }

  void encryptDecryptTest() {
    test('encrypt and decrypt', () {
      final instance = AESEncrypter(key);
      final message = 'The quick brown fox jumps over the lazy dog.' * 2;
      final encrypted = instance.encrypt(data: message);
      expect(encrypted, isNotNull);
      expect(encrypted, isNot(equals(message)));
      final decrypted = instance.decrypt(data: encrypted);
      expect(decrypted, equals(message));
    });

    test('encrypt long message', () {
      final instance = AESEncrypter(key);
      final message = 'The quick brown fox jumps over the lazy dog. ' * 20;
      final encrypted = instance.encrypt(data: message);
      expect(encrypted, hasLength(greaterThan(message.length)));
    });

    test('encrypt and decrypt with special characters', () {
      final instance = AESEncrypter(key);
      const message = r'!@#$%^&*()_+-=[]{};:\",.<>/?\\|';
      final encrypted = instance.encrypt(data: message);
      expect(encrypted, isNotNull);
      expect(encrypted, isNot(equals(message)));
      final decrypted = instance.decrypt(data: encrypted);
      expect(decrypted, equals(message));
    });
  }
}
