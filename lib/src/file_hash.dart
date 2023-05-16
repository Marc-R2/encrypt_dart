import 'dart:io';

import 'package:crypto/crypto.dart' as crypto;

class FileHash {
  static const Map<FileHashType, crypto.Hash> _typeMap = {
    FileHashType.sha1: crypto.sha1,
    FileHashType.sha224: crypto.sha224,
    FileHashType.sha256: crypto.sha256,
    FileHashType.sha384: crypto.sha384,
    FileHashType.sha512: crypto.sha512,
    FileHashType.sha512_224: crypto.sha512224,
    FileHashType.sha512_256: crypto.sha512256,
  };

  const FileHash.fromFile({required this.file});

  FileHash.fromFilePath({required String path}) : file = File(path);

  final File file;

  Future<crypto.Digest> hashDig(FileHashType type) =>
      file.openRead().transform(_typeMap[type]!).first;

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
  sha1,
  sha224,
  sha256,
  sha384,
  sha512,
  sha512_224,
  sha512_256,
}
