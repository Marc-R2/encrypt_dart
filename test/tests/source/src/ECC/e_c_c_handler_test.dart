// This file works with test_builder
// @MarcR2 (Marc Renken) - https://github.com/MarcR2/test_builder

import 'dart:math';

import 'package:crypt/encrypt.dart';
import 'package:ecdsa/ecdsa.dart';
import 'package:elliptic/elliptic.dart';
import 'package:test_builder/test_builder.dart';
import '../../../../.testGen/source/src/ECC/e_c_c_handler.test_gen.dart';

void main() {
  ECCHandlerTest();
}

class ECCHandlerTest extends ECCHandlerTestTop {
  ECCHandlerTest() {
    encryptDecryptTest();
  }

  @override
  void publicKeyTestGetter() {
    final handler = ECCHandler();
    test('publicKeyTest', () {
      expect(handler.publicKey, handler.session.publicKeyString);
      expect(handler.publicKey, hasLength(greaterThan(100)));
    });
  }

  void testEncryptDecrypt({
    required ECCHandler handlerA,
    required ECCHandler handlerB,
  }) {
    final rndStr = getRandomString(128, 2048 * 2 * 2);
    final encrypted = handlerA.encrypt(
      data: rndStr,
      key: handlerB.publicKey,
    );
    final decrypted = handlerB.decrypt(
      data: encrypted,
      key: handlerA.publicKey,
    );
    expect(decrypted, rndStr);
  }

  static String getRandomString(int length, int max) {
    final rnd = Random();
    return String.fromCharCodes(
      List.generate(length, (_) => rnd.nextInt(max)),
    );
  }

  void encryptDecryptTest() {
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

    test(
      'test different lengths of data',
      skip: true,
      () {
        for (var i = 1; i < 2048; i++) {
          final data = getRandomString(i, 2048 * 2 * 2);
          final encrypted = A.encrypt(data: data, key: B.publicKey);
          expect(encrypted, isNot(data));
          final decrypted = B.decrypt(data: encrypted, key: A.publicKey);
          expect(decrypted, data);
        }
      },
    );

    group(
      'test multiple encryption targets',
      onPlatform: {'js': const Skip('This test is too slow in js')},
      // skip: true,
      () {
        test('1234', () {
          Encryptor.expireTime = 1;
          final mainHandler = ECCHandler();
          final handlers = List.generate(512, (_) => ECCHandler());
          for (final entry in handlers.asMap().entries) {
            testEncryptDecrypt(handlerA: mainHandler, handlerB: entry.value);
            if (entry.key < 128) {
              expect(mainHandler.instanceCount, lessThanOrEqualTo(128));
              expect(mainHandler.instanceCount, equals(entry.key + 1));
            } else {
              expect(mainHandler.instanceCount, lessThan(256));
              expect(mainHandler.instanceCount, greaterThanOrEqualTo(128));
            }
          }
          print(handlers.length);
          expect(mainHandler.instanceCount, lessThan(256));
          expect(mainHandler.instanceCount, greaterThanOrEqualTo(128));
        });
      },
    );
  }

  @override
  void hashDataTest() {
    // TODO: implement hashDataTest
  }

  static final privateKey = getP384().generatePrivateKey();

  static final publicKey = privateKey.publicKey;

  static final privateKeyHex = privateKey.toHex();

  static final publicKeyHex = publicKey.toHex();

  @override
  void signDataTest() {
    test('aaa', () {
      final data = 'abc' * 16;

      final hash = ECCHandler.hashData(data);
      final sig = signature(privateKey, hash);
      print(sig.toDERHex());
      print(sig.toCompactHex());
      print(sig.toASN1Hex());
      final v = verify(publicKey, hash, Signature.fromDERHex(sig.toASN1Hex()));

      expect(v, true);
    });
  }

  @override
  void verifyDataTest() {
    test('verifyDataTest', () {
      final data = 'abc' * 16;

      final s = ECCHandler.signData(data: data, privateKey: privateKeyHex);
      print(s);
      final v = ECCHandler.verifyData(
        data: data,
        signature: s,
        publicKey: publicKeyHex,
      );
      expect(v, true);
    });
  }

  @override
  void signingCurveTestGetter() {}
}
