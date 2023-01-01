/// Support for doing something awesome.
///
/// More dartdocs go here.
library encrypt;

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:log_message/logger.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/api.dart' as pc;
import 'package:pointycastle/pointycastle.dart';
import 'package:crypto/crypto.dart' as crypto;

// /
part 'src/crypt_aes.dart';
part 'src/encrypt.dart';
part 'src/encryption_type.dart';
part 'src/hash.dart';

// /RSA
part 'src/RSA/rsa_decryptor.dart';
part 'src/RSA/rsa_encryption_handler.dart';
part 'src/RSA/rsa_encryptor.dart';
