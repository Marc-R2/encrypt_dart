import 'dart:io';

import 'package:crypto/crypto.dart' as crypto;

class FileHash {
  const FileHash.fromFile({required this.file});

  FileHash.fromFilePath({required String path}) : file = File(path);

  final File file;

  Future<crypto.Digest> hashDig(FileHashType type) =>
      file.openRead().transform(type.algorithm).first;

  Future<String> hash(FileHashType type) async =>
      (await hashDig(type)).toString();

  Future<String> sha1() => hash(FileHashType.sha1);

  Future<String> sha224() => hash(FileHashType.sha224);

  Future<String> sha256() => hash(FileHashType.sha256);

  Future<String> sha384() => hash(FileHashType.sha384);

  Future<String> sha512() => hash(FileHashType.sha512);

  Future<String> sha512_224() => hash(FileHashType.sha512_224);

  Future<String> sha512_256() => hash(FileHashType.sha512_256);

  Future<String> operator [](FileHashType type) => hash(type);
}

enum FileHashType {
  sha1(algorithm: crypto.sha1),
  sha224(algorithm: crypto.sha224),
  sha256(algorithm: crypto.sha256),
  sha384(algorithm: crypto.sha384),
  sha512(algorithm: crypto.sha512),
  sha512_224(algorithm: crypto.sha512224),
  sha512_256(algorithm: crypto.sha512256);

  const FileHashType({required this.algorithm});

  final crypto.Hash algorithm;
}
