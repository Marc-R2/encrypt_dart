import 'package:test/test.dart';

import 'src/AES/aes_encrypter_test.dart' as aes_encrypter;
import 'src/AES/aes_handler_test.dart' as aes_handler;
import 'src/RSA/rsa_decryptor_test.dart' as rsa_decryptor;
import 'src/RSA/rsa_encryption_handler_test.dart' as rsa_encryption_handler;
import 'src/RSA/rsa_encryptor_test.dart' as rsa_encryptor;
import 'src/encrypt_test.dart' as encrypt;
import 'src/hash_file_test.dart' as hash_file;
import 'src/hash_test.dart' as hash;

void main() {
  // Encrypt
  encrypt.main();

  // AES
  aes_encrypter.main();
  aes_handler.main();

  // RSA
  group(
    'RSA',
    skip: true,
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
