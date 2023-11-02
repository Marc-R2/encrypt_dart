// This file works with test_builder
// @MarcR2 (Marc Renken) - https://github.com/MarcR2/test_builder

import 'package:crypt/encrypt.dart';
import 'package:test/scaffolding.dart';
import 'package:test_builder/test_builder.dart';
import '../../../.testGen/source/src/encrypt.test_gen.dart';

void main() {
  EncryptTest();
}

class EncryptTest extends EncryptTestTop {
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
  void decryptTest() {}

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
    encryptDecryptTest();
  }

  void encryptDecryptTest() {
    group(
      'rsa',
      onPlatform: {'js': const Skip('Take too long on js')},
      () {
        final key = Encrypt.rsaPublicKey;

        test('should correctly encrypt and decrypt message with rsa', () {
          const message = 'This is a test message';
          final encrypted = Encrypt.encrypt(
            data: message,
            key: key,
            encryption: EncryptionType.rsa,
          );
          final decrypted = Encrypt.decrypt(
            data: encrypted!,
            encryption: EncryptionType.rsa,
          );
          expect(decrypted, message);
          expect(encrypted.length, 2);
        });

        test('should return null on decrypting invalid message', () {
          final invalidMessage = ['This is not a valid encrypted message'];
          final decrypted = Encrypt.decrypt(data: invalidMessage);
          expect(decrypted, isNull);
        });
      },
    );

    group('aes', () {
      const key = 'super strong key with -:- more than 32 characters';

      test('should correctly encrypt and decrypt message with aes', () {
        const message = 'This is a test message';
        final encrypted = Encrypt.encrypt(
          data: message,
          key: key,
          encryption: EncryptionType.aes,
        );
        final decrypted = Encrypt.decrypt(
          data: encrypted!,
          key: key,
          encryption: EncryptionType.aes,
        );
        expect(decrypted, message);
        expect(encrypted.length, 2);
      });

      test('should return null on decrypting invalid message', () {
        final invalidMessage = ['This is not a valid encrypted message'];
        final decrypted = Encrypt.decrypt(
          data: invalidMessage,
          encryption: EncryptionType.aes,
        );
        expect(decrypted, isNull);
      });
    });

    group('ecc', () {
      final key = Encrypt.eccPublicKey;

      test('should correctly encrypt and decrypt message with ecc', () {
        const message = 'This is a test message';
        print(key);
        final encrypted = Encrypt.encrypt(data: message, key: key);
        final decrypted = Encrypt.decrypt(data: encrypted!, key: key);
        expect(decrypted, message);
        expect(encrypted.length, 2);
      });

      test('should return null on decrypting invalid message', () {
        final invalidMessage = ['This is not a valid encrypted message'];
        final decrypted = Encrypt.decrypt(data: invalidMessage);
        expect(decrypted, isNull);
      });
    });
  }

  @override
  void rsaPublicKeyTestGetter() {
    // TODO: implement rsaPublicKeyTestGetter
  }
}
