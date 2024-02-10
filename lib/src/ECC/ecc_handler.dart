part of '../../encrypt.dart';

/// A class that contains all the methods to encrypt and decrypt data using ECC.
@TestGen()
class ECCHandler extends EncryptHandler<ECCEncryptor> with Logging {
  /// The current session with the ECC key pair
  late final session = ECCDecryptor();

  /// Get the public key of the session
  String get publicKey => session.publicKeyString;

  @override
  @TestGen.exclude()
  ECCEncryptor createInstance(String key) => ECCEncryptor(key, session);

  static elliptic.Curve get signingCurve => elliptic.getP384();

  static List<int> hashData(String data) {
    final charSum = data.codeUnits.reduce((a, b) => a + b);
    return Hash.hmacSha256(data, '$charSum-${data.length}').bytes;
  }

  /// Sign given [data] using the ECC algorithm
  static String signData({required String data, required String privateKey}) {
    final hash = hashData(data);
    final priv = elliptic.PrivateKey.fromHex(signingCurve, privateKey);
    return signature(priv, hash).toASN1Hex();
  }

  /// Verify given [data] using the ECC algorithm
  static bool verifyData({
    required String data,
    required String publicKey,
    required String signature,
  }) {
    final hash = hashData(data);
    final pub = elliptic.PublicKey.fromHex(signingCurve, publicKey);
    return verify(pub, hash, Signature.fromASN1Hex(signature));
  }
}
