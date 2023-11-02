part of '../../encrypt.dart';

@TestGen()
class ECCEncryptor extends Encryptor with Logging {
  factory ECCEncryptor(String publicKey, ECCDecryptor session) {
    final key = elliptic.PublicKey.fromHex(session.curve, publicKey);
    return ECCEncryptor._fromKey(keyFromSecret(session.computeSecret(key)));
  }

  ECCEncryptor._fromKey(Key key) : super(AES(key));

  static Key keyFromSecret(String secret) {
    final charUnitsSum = secret.codeUnits.reduce((a, b) => a + b);
    final key = (secret.split('')..shuffle(Random(charUnitsSum))).take(32);
    return Key.fromUtf8(key.join());
  }

  // TODO(Marc-R2): Investigate
  final iv = IV.allZerosOfLength(16);

  @override
  String decrypt({required String data, required Log? context}) {
    final log = functionStart('decrypt', context);
    return useEncrypter((e) => e.decrypt64(data, iv: iv), log);
  }

  @override
  List<int> decryptBinary({required Uint8List data, Log? context}) {
    final log = functionStart('decryptBinary', context);
    return useEncrypter((e) => e.decryptBytes(Encrypted(data), iv: iv), log);
  }

  @override
  String encrypt({required String data, required Log? context}) {
    final log = functionStart('encrypt', context);
    return useEncrypter((e) => e.encrypt(data, iv: iv).base64, log);
  }

  @override
  List<int> encryptBinary({required List<int> data, Log? context}) {
    final log = functionStart('encryptBinary', context);
    return useEncrypter((e) => e.encryptBytes(data, iv: iv).bytes, log);
  }
}
