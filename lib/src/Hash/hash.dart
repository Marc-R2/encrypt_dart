part of '../hash.dart';

/// Class with Static methods to hash strings
class Hash {
  static Uint8List toBytes(String input) =>
      Uint8List.fromList(utf8.encode(input));

  static HashedString hash(crypto.Hash hash, String input) =>
      HashedString(hash, input);

  /// [Hashed] a given [input] String with sha1.
  static HashedString sha1(String input) => hash(crypto.sha1, input);

  /// [Hashed] a given [input] String with sha224.
  static HashedString sha224(String input) => hash(crypto.sha224, input);

  /// Hashes a given [input] String with sha256.
  static HashedString sha256(String input) => hash(crypto.sha256, input);

  /// [Hashed] a given [input] String with sha384.
  static HashedString sha384(String input) => hash(crypto.sha384, input);

  /// [Hashed] a given [input] String with sha512.
  static HashedString sha512(String input) => hash(crypto.sha512, input);

  /// [Hashed] a given [input] String with sha512/224.
  static HashedString sha512_224(String input) => hash(crypto.sha512224, input);

  /// [Hashed] a given [input] String with sha512/256.
  static HashedString sha512_256(String input) => hash(crypto.sha512256, input);

  /// [Hashed] a given [input] String with md5.
  static HashedString md5(String input) => hash(crypto.md5, input);

  /// [HashedHmac] a given [input] and [key] String with hmac with sha1.
  static HashedHmacString hmacSha1(String input, String key) =>
      sha1(input).hmac(key);

  /// [HashedHmac] a given [input] and [key] String with hmac with sha224.
  static HashedHmacString hmacSha224(String input, String key) =>
      sha224(input).hmac(key);

  /// [HashedHmac] a given [input] and [key] String with hmac with sha256.
  static HashedHmacString hmacSha256(String input, String key) =>
      sha256(input).hmac(key);

  /// [HashedHmac] a given [input] and [key] String with hmac with sha384.
  static HashedHmacString hmacSha384(String input, String key) =>
      sha384(input).hmac(key);

  /// [HashedHmac] a given [input] and [key] String with hmac with sha512.
  static HashedHmacString hmacSha512(String input, String key) =>
      sha512(input).hmac(key);

  /// [HashedHmac] a given [input] and [key] String with hmac with sha512/224.
  static HashedHmacString hmacSha512_224(String input, String key) =>
      sha512_224(input).hmac(key);

  /// [HashedHmac] a given [input] and [key] String with hmac with sha512/256.
  static HashedHmacString hmacSha512_256(String input, String key) =>
      sha512_256(input).hmac(key);

  /// [HashedHmac] a given [input] and [key] String with hmac with md5.
  static HashedHmacString hmacMd5(String input, String key) =>
      md5(input).hmac(key);
}
