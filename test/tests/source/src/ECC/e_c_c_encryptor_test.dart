// This file works with test_builder
// @MarcR2 (Marc Renken) - https://github.com/MarcR2/test_builder

import 'package:test_builder/test_builder.dart';
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
}
