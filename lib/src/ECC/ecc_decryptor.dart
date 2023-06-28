part of '../../encrypt.dart';

class ECCDecryptor extends ECCEncryptor {
  ECCDecryptor() : super._parent() {
    _privateKey = curve.generatePrivateKey();
  }

  late final elliptic.PublicKey? _publicKey;

  elliptic.PublicKey get publicKey => _publicKey ??= _privateKey.publicKey;

  late final elliptic.PrivateKey _privateKey;

  String get publicKeyString => publicKey.toHex();

  String computeSecret(elliptic.PublicKey publicKey) =>
      computeSecretHex(_privateKey, publicKey);
}
