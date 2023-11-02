// This file works with test_builder
// @MarcR2 (Marc Renken) - https://github.com/MarcR2/test_builder

import 'dart:typed_data';

import 'package:crypt/encrypt.dart';
import 'package:test/scaffolding.dart';
import 'package:test_builder/test_builder.dart';
import '../../../.testGen/source/src/encrypt.test_gen.dart';

void main() {
  EncryptTest();
}

class EncryptTest extends EncryptTestTop {
  EncryptTest() {
    encryptDecryptTest();
    encryptDecryptBinaryTest();
  }

  static const typesWithoutRSA = [
    EncryptionType.aes,
    EncryptionType.ecc,
    EncryptionType.none,
  ];

  static const typesJustRSA = [EncryptionType.rsa];

  static const typesAll = EncryptionType.values;

  @override
  void splitIntoBlocksTest() {
    void expectBlocks(
      int length,
      int blockCount,
      List<EncryptionType> types,
    ) {
      for (final type in types) {
        final sample = List.generate(length, (i) => i % 9);
        final blocks = Encrypt.splitIntoBlocks(sample.join(), type);
        expect(blocks, hasLength(blockCount));
        expect(blocks.join(), sample.join());
      }
    }

    test('splitIntoBlocksTest', () {
      expectBlocks(0, 0, typesAll);
      expectBlocks(1, 1, typesAll);
      expectBlocks(2, 1, typesAll);
      expectBlocks(4, 1, typesAll);
      expectBlocks(8, 1, typesAll);
      expectBlocks(16, 1, typesAll);
      expectBlocks(32, 1, typesAll);
      expectBlocks(64, 1, typesAll);
      expectBlocks(128, 1, typesAll);
      expectBlocks(256, 1, typesWithoutRSA);
      expectBlocks(256, 2, typesJustRSA);
      expectBlocks(512, 1, typesWithoutRSA);
      expectBlocks(512, 3, typesJustRSA);
      expectBlocks(1024, 1, typesWithoutRSA);
      expectBlocks(1024, 6, typesJustRSA);
      expectBlocks(2048, 2, typesWithoutRSA);
      expectBlocks(2048, 11, typesJustRSA);
      expectBlocks(4096, 4, typesWithoutRSA);
      expectBlocks(4096, 21, typesJustRSA);
      expectBlocks(8192, 8, typesWithoutRSA);
      expectBlocks(8192, 41, typesJustRSA);
      expectBlocks(16384, 2, typesWithoutRSA);
      expectBlocks(16384, 82, typesJustRSA);
      expectBlocks(32768, 4, typesWithoutRSA);
      expectBlocks(32768, 164, typesJustRSA);
      expectBlocks(65536, 8, typesWithoutRSA);
      expectBlocks(65536, 328, typesJustRSA);
    });
  }

  @override
  void decryptTest() {
    // TODO: implement decryptTest
  }

  @override
  void blockHashTest() {
    // TODO: implement blockHashTest
  }

  @override
  void decryptBinaryTest() {
    // TODO: implement decryptBinaryTest
  }

  @override
  void decryptRawTest() {
    // TODO: implement decryptRawTest
  }

  @override
  void eccPublicKeyTestGetter() {
    // TODO: implement eccPublicKeyTestGetter
  }

  @override
  void encryptBinaryTest() {
    // TODO: implement encryptBinaryTest
  }

  @override
  void encryptRawTest() {
    // TODO: implement encryptRawTest
  }

  @override
  void encryptTest() {
    // TODO: implement encryptTest
  }

  void encryptDecryptTestPart({
    required String groupName,
    required String key,
    required EncryptionType encryption,
    Map<String, dynamic> onPlatform = const {},
  }) {
    group(
      groupName,
      onPlatform: onPlatform,
      () {
        test('should be able to reconstruct message with $groupName', () {
          const message = 'This is a test message';
          final encrypted = Encrypt.encrypt(
            data: message,
            key: key,
            encryption: encryption,
          );
          final decrypted = Encrypt.decrypt(
            data: encrypted!,
            key: key,
            encryption: encryption,
          );
          expect(decrypted, message);
          expect(encrypted.length, 2);
        });

        test('should return null on decrypting invalid message', () {
          final invalidMessage = ['This is not a valid encrypted message'];
          final decrypted = Encrypt.decrypt(
            data: invalidMessage,
            key: key,
            encryption: encryption,
          );
          expect(decrypted, isNull);
        });
      },
    );
  }

  void encryptDecryptTest() {
    group('String', () {
      encryptDecryptTestPart(
        groupName: 'rsa',
        key: Encrypt.rsaPublicKey,
        encryption: EncryptionType.rsa,
        onPlatform: {'js': const Skip('RSA is too slow in js')},
      );

      encryptDecryptTestPart(
        groupName: 'aes',
        key: 'super strong key with -:- more than 32 characters',
        encryption: EncryptionType.aes,
      );

      encryptDecryptTestPart(
        groupName: 'ecc',
        key: Encrypt.eccPublicKey,
        encryption: EncryptionType.ecc,
      );
    });
  }

  void encryptDecryptBinaryTestPart({
    required String groupName,
    required String key,
    required EncryptionType encryption,
    Map<String, dynamic> onPlatform = const {},
  }) {
    group(
      groupName,
      onPlatform: onPlatform,
      () {
        test('should correctly reconstruct binary with $groupName', () {
          const message = 'This is a test message';
          final encrypted = Encrypt.encryptBinary(
            data: message.codeUnits,
            key: key,
            encryption: encryption,
          );
          final decrypted = Encrypt.decryptBinary(
            data: Uint8List.fromList(encrypted),
            key: key,
            encryption: encryption,
          );
          expect(decrypted, message.codeUnits);
        });

        /* test('should return null on decrypting invalid message', () {
          final invalidMessage = List.generate(128, (i) => i);
          final decrypted = Encrypt.decryptBinary(
            data: Uint8List.fromList(invalidMessage),
            key: key,
            encryption: encryption,
          );
          expect(decrypted, isNull);
        }); */
      },
    );
  }

  void encryptDecryptBinaryTest() {
    group('binary', () {
      encryptDecryptBinaryTestPart(
        groupName: 'rsa',
        key: Encrypt.rsaPublicKey,
        encryption: EncryptionType.rsa,
        onPlatform: {'js': const Skip('RSA is too slow in js')},
      );

      encryptDecryptBinaryTestPart(
        groupName: 'aes',
        key: 'super strong key with -:- more than 32 characters',
        encryption: EncryptionType.aes,
      );

      encryptDecryptBinaryTestPart(
        groupName: 'ecc',
        key: Encrypt.eccPublicKey,
        encryption: EncryptionType.ecc,
      );
    });
  }

  @override
  void rsaPublicKeyTestGetter() {
    // TODO: implement rsaPublicKeyTestGetter
  }
}
