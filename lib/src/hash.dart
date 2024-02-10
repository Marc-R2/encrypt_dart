part of '../encrypt.dart';

abstract class Hashed<T> {
  const Hashed(this.hashAlgo, this.data);

  final crypto.Hash hashAlgo;

  final T data;

  Uint8List convertBytes(T data);

  Uint8List get dataBytes => convertBytes(data);

  crypto.Digest get hashDig => hashAlgo.convert(dataBytes);

  Uint8List get hashBytes => Uint8List.fromList(hashDig.bytes);

  String get hashString => hashDig.toString();

  String substring(int start, [int? end]) => hashString.substring(start, end);
}

mixin ConvertDataString {
  Uint8List convertBytes(String data) => Uint8List.fromList(utf8.encode(data));
}

mixin ConvertDataBytes {
  Uint8List convertBytes(Uint8List data) => data;
}

class HashedString extends Hashed<String> with ConvertDataString {
  const HashedString(super.hashAlgo, super.data);

  HashedHmacString hmac(String key) => HashedHmacString(hashAlgo, data, key);
}

class HashedBytes extends Hashed<Uint8List> with ConvertDataBytes {
  const HashedBytes(super.hashAlgo, super.data);

  HashedHmacBytes hmac(Uint8List key) => HashedHmacBytes(hashAlgo, data, key);
}

abstract class HashedHmac<T, K> extends Hashed<T> {
  const HashedHmac(super.hashAlgo, super.data, this.key);

  final K key;

  Uint8List convertKey(K key);

  Uint8List get keyBytes => convertKey(key);

  @override
  crypto.Digest get hashDig =>
      crypto.Hmac(hashAlgo, keyBytes).convert(dataBytes);
}

mixin ConvertKeyString {
  Uint8List convertKey(String key) => Uint8List.fromList(utf8.encode(key));
}

mixin ConvertKeyBytes {
  Uint8List convertKey(Uint8List key) => key;
}

class HashedHmacString extends HashedHmac<String, String>
    with ConvertDataString, ConvertKeyString {
  HashedHmacString(super.hashAlgo, super.data, super.key);
}

class HashedHmacBytes extends HashedHmac<Uint8List, Uint8List>
    with ConvertDataBytes, ConvertKeyBytes {
  const HashedHmacBytes(super.hashAlgo, super.data, super.key);
}

/// Class with Static methods to hash strings
class Hash {
  static Uint8List toBytes(String input) =>
      Uint8List.fromList(utf8.encode(input));

  /// [Hashed] a given [input] String with sha1.
  static HashedString sha1(String input) => HashedString(crypto.sha1, input);

  /// [Hashed] a given [input] String with sha224.
  static HashedString sha224(String input) =>
      HashedString(crypto.sha224, input);

  /// Hashes a given [input] String with sha256.
  static HashedString sha256(String input) =>
      HashedString(crypto.sha256, input);

  /// [Hashed] a given [input] String with sha384.
  static HashedString sha384(String input) =>
      HashedString(crypto.sha384, input);

  /// [Hashed] a given [input] String with sha512.
  static HashedString sha512(String input) =>
      HashedString(crypto.sha512, input);

  /// [Hashed] a given [input] String with sha512/224.
  static HashedString sha512_224(String input) =>
      HashedString(crypto.sha512224, input);

  /// [Hashed] a given [input] String with sha512/256.
  static HashedString sha512_256(String input) =>
      HashedString(crypto.sha512256, input);

  /// [Hashed] a given [input] String with md5.
  static HashedString md5(String input) => HashedString(crypto.md5, input);

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
}
