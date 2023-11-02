import 'package:test/test.dart';

import 'main_test.dart' as test_gen;
import 'src/RSA/rsa_decryptor_test.dart' as rsa_decryptor;
import 'src/RSA/rsa_encryption_handler_test.dart' as rsa_encryption_handler;
import 'src/RSA/rsa_encryptor_test.dart' as rsa_encryptor;
import 'src/hash_file_test.dart' as hash_file;
import 'src/hash_test.dart' as hash;

void main() {
  // TestGen
  test_gen.main();

  // RSA
  group(
    'RSA',
    onPlatform: {'js': const Skip('Take too long on js')},
    () {
      rsa_encryptor.main();
      rsa_decryptor.main();
      rsa_encryption_handler.main();
    },
  );

  // Hash
  hash.main();
  hash_file.main();
}
