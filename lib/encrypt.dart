/// Support for doing something awesome.
///
/// More dartdocs go here.
library crypt;

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;
import 'package:elliptic/ecdh.dart';
import 'package:elliptic/elliptic.dart' as elliptic;
import 'package:encrypt/encrypt.dart';
import 'package:log_message/logger.dart';
import 'package:pointycastle/api.dart' as pc;
import 'package:pointycastle/pointycastle.dart' hide Algorithm;
import 'package:test_builder_annotation/test_builder_annotation.dart';

export 'src/file_hash.dart';

// /AES
part 'src/AES/aes_handler.dart';
part 'src/AES/aes_encrypter.dart';

// /RSA
part 'src/RSA/rsa_decryptor.dart';
part 'src/RSA/rsa_handler.dart';
part 'src/RSA/rsa_encryptor.dart';
part 'src/RSA/rsa_generate_key.dart';

// /ECC
part 'src/ECC/ecc_handler.dart';
part 'src/ECC/ecc_encryptor.dart';
part 'src/ECC/ecc_decryptor.dart';

// /
part 'src/encrypt.dart';
part 'src/encryption_type.dart';
part 'src/hash.dart';

part 'src/abstract/encrypt_handler.dart';
part 'src/abstract/encryptor.dart';
