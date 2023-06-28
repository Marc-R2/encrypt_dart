part of '../../encrypt.dart';

@TestGen()
class ECCEncryptor extends Encryptor with Logging {
  factory ECCEncryptor(String publicKey, ECCDecryptor session) {
    final key = elliptic.PublicKey.fromHex(session.curve, publicKey);
    return ECCEncryptor.fromSecret(session.computeSecret(key));
  }

  ECCEncryptor.fromSecret(String secret) : assert(secret.length == 132) {
    final charUnitsSum = secret.codeUnits.reduce((a, b) => a + b);
    final key = (secret.split('')..shuffle(Random(charUnitsSum))).take(32);
    _encrypter = Encrypter(AES(Key.fromUtf8(key.join())));
  }

  late final Encrypter _encrypter;

  final iv = IV.fromLength(16);

  @TestGen.exclude()
  String useEncrypter(String Function(Encrypter e) f, Log? context) {
    final log = functionStart('useEncrypter', context);
    try {
      _updateLastUsed();
      return f(_encrypter);
    } catch (e) {
      throw log.exception(
        title: 'Error while using encrypter',
        message: '$e',
      );
    }
  }

  @override
  String decrypt({required String data, required Log? context}) {
    final log = functionStart('decrypt', context);
    return useEncrypter((e) => e.decrypt64(data, iv: iv), log);
  }

  @override
  String encrypt({required String data, required Log? context}) {
    final log = functionStart('encrypt', context);
    return useEncrypter((e) => e.encrypt(data, iv: iv).base64, log);
  }
}
