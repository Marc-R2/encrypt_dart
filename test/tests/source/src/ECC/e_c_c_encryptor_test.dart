// This file works with test_builder
// @MarcR2 (Marc Renken) - https://github.com/MarcR2/test_builder

import 'package:crypt/encrypt.dart';
import 'package:encrypt/encrypt.dart';
import 'package:test/expect.dart';

import '../../../../.testGen/source/src/ECC/e_c_c_encryptor.test_gen.dart';

void main() {
  ECCEncryptorTest();
}

class ECCEncryptorTest extends ECCEncryptorTestTop {
  @override
  void decryptTest() {
    // TODO: Implement tests
    test('decryptTest', () {});
  }

  @override
  void encryptTest() {
    // TODO: Implement tests
    test('encryptTest', () {});
  }

  @override
  void keyFromSecretTest() {
    final simpleSecret = 'your_secret_here' * 4;

    test('Test keyFromSecret returns non-null key', () {
      final key = ECCEncryptor.keyFromSecret(simpleSecret);
      expect(key, isNotNull);
    });

    test('Test keyFromSecret returns Key instance', () {
      final key = ECCEncryptor.keyFromSecret(simpleSecret);
      expect(key, isA<Key>());
    });

    test('Test keyFromSecret returns key with correct length', () {
      final key = ECCEncryptor.keyFromSecret(simpleSecret);
      expect(key.bytes.length, equals(32));
    });
  }

  @override
  void constructorTest() {
    // TODO: implement constructorTest
  }

  @override
  void constructor_fromKeyTest() {
    // TODO: implement constructor_fromKeyTest
  }

  @override
  void decryptBinaryTest() {
    // TODO: implement decryptBinaryTest
  }

  @override
  void encryptBinaryTest() {
    // TODO: implement encryptBinaryTest
  }
}
