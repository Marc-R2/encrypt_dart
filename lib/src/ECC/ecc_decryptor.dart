part of '../../encrypt.dart';

@TestGen.exclude()
class ECCDecryptor extends ECCEncryptor {
  ///
  factory ECCDecryptor() {
    final curve = elliptic.getP521();
    final privateKey = curve.generatePrivateKey();
    final publicKey = privateKey.publicKey;
    return ECCDecryptor._(
      curve: curve,
      privateKey: privateKey,
      publicKey: publicKey,
    );
  }

  ECCDecryptor._({
    required this.curve,
    required elliptic.PrivateKey privateKey,
    required this.publicKey,
  })  : _privateKey = privateKey,
        super._fromKey(Key.fromUtf8(''));

  final elliptic.Curve curve;

  final elliptic.PublicKey publicKey;

  final elliptic.PrivateKey _privateKey;

  String get publicKeyString => publicKey.toHex();

  String computeSecret(elliptic.PublicKey publicKey) =>
      computeSecretHex(_privateKey, publicKey);
}
