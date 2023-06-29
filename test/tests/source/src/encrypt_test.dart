// This file works with test_builder
// @MarcR2 (Marc Renken) - https://github.com/MarcR2/test_builder

import 'package:crypt/encrypt.dart';
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
}
