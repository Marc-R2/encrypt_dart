part of '../../encrypt.dart';


class ECCEncryptor extends Encryptor with Logging {
  ECCEncryptor(String publicKey, ECCDecryptor session) {
    final key = elliptic.PublicKey.fromHex(curve, publicKey);
    final secretHex = session.computeSecret(key);
    _encrypter = Encrypter(AES(Key.fromUtf8(secretHex.substring(0, 32))));
  }

  ECCEncryptor._parent();

  elliptic.Curve get curve => elliptic.getSecp521r1();

  late final Encrypter _encrypter;

  final iv = IV.fromLength(16);

  String useEncrypter(String Function() f, Log? context) {
    final log = functionStart('useEncrypter', context);
    try {
      _updateLastUsed();
      return f();
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
    return useEncrypter(() => _encrypter.decrypt64(data, iv: iv), log);
  }

  @override
  String encrypt({required String data, required Log? context}) {
    final log = functionStart('encrypt', context);
    return useEncrypter(() => _encrypter.encrypt(data, iv: iv).base64, log);
  }
}
