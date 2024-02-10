part of '../../encrypt.dart';

/// Allow to encrypt and decrypt messages using AES
@TestGen()
class AESEncrypter extends Encryptor with Logging {
  /// Create a new AES instance with the given [secret].
  factory AESEncrypter(String secret) =>
      AESEncrypter._withKey(keyFromSecret(secret));

  AESEncrypter._withKey(Key key) : super(AES(key));

  static Key keyFromSecret(String secret) {
    final parts = secret.split('-:-');
    final lengths = parts[0].length + parts[1].length;

    final charSum = secret.codeUnits.reduce((a, b) => a + b);

    final keyHash = Hash.hmacSha256(secret, 'aesKey:$lengths:$charSum');
    final key = keyHash.hashString.split('')..shuffle(Random(charSum));

    return Key.fromUtf8(key.take(32).join());
  }


  final iv = IV.fromLength(16);

  /// Encrypt a message
  @override
  String encrypt({required String data, Log? context}) {
    final log = functionStart('encrypt', context);
    return useEncrypter((e) => e.encrypt(data, iv: iv).base64, log);
  }

  @override
  List<int> encryptBinary({required List<int> data, Log? context}) {
    final log = functionStart('encryptBinary', context);
    return useEncrypter((e) => e.encryptBytes(data, iv: iv).bytes, log);
  }

  /// Decrypt a message
  @override
  String decrypt({required String data, Log? context}) {
    final log = functionStart('decrypt', context);
    return useEncrypter((e) => e.decrypt64(data, iv: iv), log);
  }

  @override
  List<int> decryptBinary({required Uint8List data, Log? context}) {
    final log = functionStart('decryptBinary', context);
    return useEncrypter((e) => e.decryptBytes(Encrypted(data), iv: iv), log);
  }
}
