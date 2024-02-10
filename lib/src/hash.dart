part of '../encrypt.dart';

class Hashed {
  const Hashed({
    required this.hashAlgo,
    String? stringData,
    Uint8List? byteData,
  })  : _stringData = stringData,
        _byteData = byteData,
        assert(
          stringData != null || byteData != null,
          'Input or bytes must be provided',
        );

  const Hashed.fromBytes(this.hashAlgo, Uint8List bytes)
      : _byteData = bytes,
        _stringData = null;

  const Hashed.fromString(this.hashAlgo, String input)
      : _stringData = input,
        _byteData = null;

  final crypto.Hash hashAlgo;

  final String? _stringData;
  final Uint8List? _byteData;

  Uint8List get bytes => _byteData ?? Hash.toBytes(_stringData!);

  crypto.Digest get hashDig => hashAlgo.convert(bytes);

  Uint8List get hashBytes => Uint8List.fromList(hashDig.bytes);

  String get hashString => hashDig.toString();

  String substring(int start, [int? end]) => hashString.substring(start, end);
}

class HashedHmac extends Hashed {
  const HashedHmac({
    required super.hashAlgo,
    String? stringData,
    Uint8List? byteData,
    String? stringKey,
    Uint8List? byteKey,
  })  : _stringKey = stringKey,
        _byteKey = byteKey,
        assert(
          stringKey != null || byteKey != null,
          'String key or byte key must be provided',
        ),
        super(stringData: stringData, byteData: byteData);

  HashedHmac.fromBytes(super.hashAlgo, super.bytes, String key)
      : _stringKey = key,
        _byteKey = null,
        super.fromBytes();

  HashedHmac.fromString(super.hashAlgo, super.input, Uint8List key)
      : _byteKey = key,
        _stringKey = null,
        super.fromString();

  final String? _stringKey;
  final Uint8List? _byteKey;

  Uint8List get key => _byteKey ?? Hash.toBytes(_stringKey!);

  @override
  crypto.Digest get hashDig => crypto.Hmac(hashAlgo, key).convert(bytes);
}

/// Class with Static methods to hash strings
class Hash {
  static Uint8List toBytes(String input) =>
      Uint8List.fromList(utf8.encode(input));

  /// [Hashed] a given [input] String with sha1.
  static Hashed sha1(String input) => Hashed.fromString(crypto.sha1, input);

  /// [Hashed] a given [input] String with sha224.
  static Hashed sha224(String input) => Hashed.fromString(crypto.sha224, input);

  /// Hashes a given [input] String with sha256.
  static Hashed sha256(String input) => Hashed.fromString(crypto.sha256, input);

  /// [Hashed] a given [input] String with sha384.
  static Hashed sha384(String input) => Hashed.fromString(crypto.sha384, input);

  /// [Hashed] a given [input] String with sha512.
  static Hashed sha512(String input) => Hashed.fromString(crypto.sha512, input);

  /// [Hashed] a given [input] String with sha512/224.
  static Hashed sha512_224(String input) =>
      Hashed.fromString(crypto.sha512224, input);

  /// [Hashed] a given [input] String with sha512/256.
  static Hashed sha512_256(String input) =>
      Hashed.fromString(crypto.sha512256, input);

  /// [Hashed] a given [input] String with md5.
  static Hashed md5(String input) => Hashed.fromString(crypto.md5, input);

  /// [HashedHmac] a given [input] and [key] String with hmac with sha1.
  static HashedHmac hmacSha1(String input, String key) =>
      HashedHmac(stringData: input, stringKey: key, hashAlgo: crypto.sha1);

  /// [HashedHmac] a given [input] and [key] String with hmac with sha224.
  static HashedHmac hmacSha224(String input, String key) =>
      HashedHmac(stringData: input, stringKey: key, hashAlgo: crypto.sha224);

  /// [HashedHmac] a given [input] and [key] String with hmac with sha256.
  static HashedHmac hmacSha256(String input, String key) =>
      HashedHmac(stringData: input, stringKey: key, hashAlgo: crypto.sha256);

  /// [HashedHmac] a given [input] and [key] String with hmac with sha384.
  static HashedHmac hmacSha384(String input, String key) =>
      HashedHmac(stringData: input, stringKey: key, hashAlgo: crypto.sha384);

  /// [HashedHmac] a given [input] and [key] String with hmac with sha512.
  static HashedHmac hmacSha512(String input, String key) =>
      HashedHmac(stringData: input, stringKey: key, hashAlgo: crypto.sha512);
}
