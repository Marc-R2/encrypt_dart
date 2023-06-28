/// Support for doing something awesome.
///
/// More dartdocs go here.
library crypt;

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypt/play.dart';
import 'package:crypt/src/RSA/rsa_key_generator.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:encrypt/encrypt.dart';
import 'package:log_message/logger.dart';
import 'package:pointycastle/api.dart' as pc;
import 'package:pointycastle/pointycastle.dart';

export 'src/file_hash.dart';

// /AES
part 'src/AES/aes_handler.dart';
part 'src/AES/aes_encrypter.dart';

// /RSA
part 'src/RSA/rsa_decryptor.dart';
part 'src/RSA/rsa_encryption_handler.dart';
part 'src/RSA/rsa_encryptor.dart';
part 'src/RSA/rsa_generate_key.dart';

// /
part 'src/encrypt.dart';
part 'src/encryption_type.dart';
part 'src/hash.dart';

part 'src/abstract/encrypt_handler.dart';
part 'src/abstract/encryptor.dart';
