part of '../encrypt.dart';

/// Class with Static methods to hash strings
class Hash {
  static Uint8List toBytes(String input) => utf8.encode(input);

  /// Hashes a given [bytes] with sha1 to Digest.
  static crypto.Digest sha1Dig(Uint8List bytes) => crypto.sha1.convert(bytes);

  static String sha1Bytes(Uint8List bytes) => sha1Dig(bytes).toString();

  /// Hashes a given [input] with sha1 to String.
  static String sha1(String input) => sha1Bytes(toBytes(input));

  /// Hashes a given [bytes] with sha224 to Digest.
  static crypto.Digest sha224Dig(Uint8List bytes) {
    return crypto.sha224.convert(bytes);
  }

  static String sha224Bytes(Uint8List bytes) => sha224Dig(bytes).toString();

  /// Hashes a given [input] with sha224 to String.
  static String sha224(String input) => sha224Bytes(toBytes(input));

  /// Hashes a given [bytes] with sha256 to Digest.
  static crypto.Digest sha256Dig(Uint8List bytes) {
    return crypto.sha256.convert(bytes);
  }

  static String sha256Bytes(Uint8List bytes) => sha256Dig(bytes).toString();

  /// Hashes a given [input] with sha256 to String.
  static String sha256(String input) => sha256Bytes(toBytes(input));

  /// Hashes a given [bytes] with sha384 to Dig.
  static crypto.Digest sha384Dig(Uint8List bytes) {
    return crypto.sha384.convert(bytes);
  }

  static String sha384Bytes(Uint8List bytes) => sha384Dig(bytes).toString();

  /// Hashes a given [input] with sha384 to String.
  static String sha384(String input) => sha384Bytes(toBytes(input));

  /// Hashes a given [bytes] with sha512 to Digest.
  static crypto.Digest sha512Dig(Uint8List bytes) {
    return crypto.sha512.convert(bytes);
  }

  static String sha512Bytes(Uint8List bytes) => sha512Dig(bytes).toString();

  /// Hashes a given [input] with sha512 to String.
  static String sha512(String input) => sha512Bytes(toBytes(input));

  /// Hashes a given [bytes] with sha512/224 to Digest.
  static crypto.Digest sha512_224Dig(Uint8List bytes) {
    return crypto.sha512224.convert(bytes);
  }

  static String sha512_224Bytes(Uint8List bytes) {
    return sha512_224Dig(bytes).toString();
  }

  /// Hashes a given [input] with sha512/224 to String.
  static String sha512_224(String input) => sha512_224Bytes(toBytes(input));

  /// Hashes a given [bytes] with sha512/256 to Digest.
  static crypto.Digest sha512_256Dig(Uint8List bytes) {
    return crypto.sha512256.convert(bytes);
  }

  static String sha512_256Bytes(Uint8List bytes) {
    return sha512_256Dig(bytes).toString();
  }

  /// Hashes a given [input] with sha512/256 to String.
  static String sha512_256(String input) => sha512_256Bytes(toBytes(input));

  /// Hashes a given [bytes] with md5 to Digest.
  static crypto.Digest md5Dig(Uint8List bytes) {
    return crypto.md5.convert(bytes);
  }

  static String md5Bytes(Uint8List bytes) => md5Dig(bytes).toString();

  /// Hashes a given [input] with md5 to String.
  static String md5(String input) => md5Bytes(toBytes(input));

  /// Hashes a given [input] and [key] with hmac with sha1 to Digest.
  static crypto.Digest hmacSha1Dig(String input, String key) {
    final bytes = toBytes(input);
    final keyBytes = toBytes(key);
    return crypto.Hmac(crypto.sha1, keyBytes).convert(bytes);
  }

  /// Hashes a given [input] and [key] with hmac with sha1 to String.
  static String hmacSha1(String input, String key) =>
      hmacSha1Dig(input, key).toString();

  /// Hashes a given [input] and [key] with hmac with sha224 to Digest.
  static crypto.Digest hmacSha224Dig(String input, String key) {
    final bytes = toBytes(input);
    final keyBytes = toBytes(key);
    return crypto.Hmac(crypto.sha224, keyBytes).convert(bytes);
  }

  /// Hashes a given [input] and [key] with hmac with sha224 to String.
  static String hmacSha224(String input, String key) =>
      hmacSha224Dig(input, key).toString();

  /// Hashes a given [input] and [key] with hmac with sha256 to Digest.
  static crypto.Digest hmacSha256Dig(String input, String key) {
    final bytes = toBytes(input);
    final keyBytes = toBytes(key);
    return crypto.Hmac(crypto.sha256, keyBytes).convert(bytes);
  }

  /// Hashes a given [input] and [key] with hmac with sha256 to String.
  static String hmacSha256(String input, String key) =>
      hmacSha256Dig(input, key).toString();

  /// Hashes a given [input] and [key] with hmac with sha384 to Digest.
  static crypto.Digest hmacSha384Dig(String input, String key) {
    final bytes = toBytes(input);
    final keyBytes = toBytes(key);
    return crypto.Hmac(crypto.sha384, keyBytes).convert(bytes);
  }

  /// Hashes a given [input] and [key] with hmac with sha384 to String.
  static String hmacSha384(String input, String key) =>
      hmacSha384Dig(input, key).toString();

  /// Hashes a given [input] and [key] with hmac with sha512 to Digest.
  static crypto.Digest hmacSha512Dig(String input, String key) {
    final bytes = toBytes(input);
    final keyBytes = toBytes(key);
    return crypto.Hmac(crypto.sha512, keyBytes).convert(bytes);
  }

  /// Hashes a given [input] and [key] with hmac with sha512 to String.
  static String hmacSha512(String input, String key) =>
      hmacSha512Dig(input, key).toString();
}
