part of '../encrypt.dart';

/// Class with Static methods to hash strings
class Hash {
  /// Hashes a given [input] with sha1 to Digest.
  static crypto.Digest sha1Dig(String input) {
    final bytes = utf8.encode(input);
    return crypto.sha1.convert(bytes);
  }

  /// Hashes a given [input] with sha1 to String.
  static String sha1(String input) => sha1Dig(input).toString();

  /// Hashes a given [input] with sha224 to Digest.
  static crypto.Digest sha224Dig(String input) {
    final bytes = utf8.encode(input);
    return crypto.sha224.convert(bytes);
  }

  /// Hashes a given [input] with sha224 to String.
  static String sha224(String input) => sha224Dig(input).toString();

  /// Hashes a given [input] with sha256 to Digest.
  static crypto.Digest sha256Dig(String input) {
    final bytes = utf8.encode(input);
    return crypto.sha256.convert(bytes);
  }

  /// Hashes a given [input] with sha256 to String.
  static String sha256(String input) => sha256Dig(input).toString();

  /// Hashes a given [input] with sha384 to Dig.
  static crypto.Digest sha384Dig(String input) {
    final bytes = utf8.encode(input);
    return crypto.sha384.convert(bytes);
  }

  /// Hashes a given [input] with sha384 to String.
  static String sha384(String input) => sha384Dig(input).toString();

  /// Hashes a given [input] with sha512 to Digest.
  static crypto.Digest sha512Dig(String input) {
    final bytes = utf8.encode(input);
    return crypto.sha512.convert(bytes);
  }

  /// Hashes a given [input] with sha512 to String.
  static String sha512(String input) => sha512Dig(input).toString();

  /// Hashes a given [input] with sha512/224 to Digest.
  static crypto.Digest sha512_224Dig(String input) {
    final bytes = utf8.encode(input);
    return crypto.sha512224.convert(bytes);
  }

  /// Hashes a given [input] with sha512/224 to String.
  static String sha512_224(String input) => sha512_224Dig(input).toString();

  /// Hashes a given [input] with sha512/256 to Digest.
  static crypto.Digest sha512_256Dig(String input) {
    final bytes = utf8.encode(input);
    return crypto.sha512256.convert(bytes);
  }

  /// Hashes a given [input] with sha512/256 to String.
  static String sha512_256(String input) => sha512_256Dig(input).toString();

  /// Hashes a given [input] with md5 to Digest.
  static crypto.Digest md5Dig(String input) {
    final bytes = utf8.encode(input);
    return crypto.md5.convert(bytes);
  }

  /// Hashes a given [input] with md5 to String.
  static String md5(String input) => md5Dig(input).toString();

  /// Hashes a given [input] and [key] with hmac with sha1 to Digest.
  static crypto.Digest hmacSha1Dig(String input, String key) {
    final bytes = utf8.encode(input);
    final keyBytes = utf8.encode(key);
    return crypto.Hmac(crypto.sha1, keyBytes).convert(bytes);
  }

  /// Hashes a given [input] and [key] with hmac with sha1 to String.
  static String hmacSha1(String input, String key) =>
      hmacSha1Dig(input, key).toString();

  /// Hashes a given [input] and [key] with hmac with sha224 to Digest.
  static crypto.Digest hmacSha224Dig(String input, String key) {
    final bytes = utf8.encode(input);
    final keyBytes = utf8.encode(key);
    return crypto.Hmac(crypto.sha224, keyBytes).convert(bytes);
  }

  /// Hashes a given [input] and [key] with hmac with sha224 to String.
  static String hmacSha224(String input, String key) =>
      hmacSha224Dig(input, key).toString();

  /// Hashes a given [input] and [key] with hmac with sha256 to Digest.
  static crypto.Digest hmacSha256Dig(String input, String key) {
    final bytes = utf8.encode(input);
    final keyBytes = utf8.encode(key);
    return crypto.Hmac(crypto.sha256, keyBytes).convert(bytes);
  }

  /// Hashes a given [input] and [key] with hmac with sha256 to String.
  static String hmacSha256(String input, String key) =>
      hmacSha256Dig(input, key).toString();

  /// Hashes a given [input] and [key] with hmac with sha384 to Digest.
  static crypto.Digest hmacSha384Dig(String input, String key) {
    final bytes = utf8.encode(input);
    final keyBytes = utf8.encode(key);
    return crypto.Hmac(crypto.sha384, keyBytes).convert(bytes);
  }

  /// Hashes a given [input] and [key] with hmac with sha384 to String.
  static String hmacSha384(String input, String key) =>
      hmacSha384Dig(input, key).toString();

  /// Hashes a given [input] and [key] with hmac with sha512 to Digest.
  static crypto.Digest hmacSha512Dig(String input, String key) {
    final bytes = utf8.encode(input);
    final keyBytes = utf8.encode(key);
    return crypto.Hmac(crypto.sha512, keyBytes).convert(bytes);
  }

  /// Hashes a given [input] and [key] with hmac with sha512 to String.
  static String hmacSha512(String input, String key) =>
      hmacSha512Dig(input, key).toString();
}
