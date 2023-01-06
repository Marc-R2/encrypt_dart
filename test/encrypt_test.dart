// AES
import 'AES/aes_encrypter_test.dart' as aes_encrypter;
import 'AES/aes_handler_test.dart' as aes_handler;

// RSA
import 'RSA/rsa_decryptor_test.dart' as rsa_decryptor;
import 'RSA/rsa_encryption_handler_test.dart' as rsa_encryption_handler;
import 'RSA/rsa_encryptor_test.dart' as rsa_encryptor;

import 'hash_test.dart' as hash;

Future<void> main() async {
  // AES
  aes_encrypter.main();
  aes_handler.main();

  // RSA
  rsa_encryptor.main();
  rsa_decryptor.main();
  rsa_encryption_handler.main();

  // Hash
  await hash.main();
}
