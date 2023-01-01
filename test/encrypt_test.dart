import 'package:test/test.dart';

import 'RSA/rsa_decryptor_test.dart' as rsa_decryptor;
import 'RSA/rsa_encryption_handler_test.dart' as rsa_encryption_handler;
import 'RSA/rsa_encryptor_test.dart' as rsa_encryptor;
import 'hash_test.dart' as hash;

Future<void> main() async {
  rsa_encryptor.main();
  rsa_decryptor.main();
  rsa_encryption_handler.main();
  hash.main();
}
