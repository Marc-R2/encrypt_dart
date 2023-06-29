part of '../../encrypt.dart';

/// Allow to encrypt and decrypt messages using a RSA key pair
class RSADecryptor extends RSAEncryptor {
  /// Constructor for RSADecryptor.
  factory RSADecryptor() =>
      RSADecryptor.fromKeyPair(sessionKeyPair: generateKeyPair());

  RSADecryptor.fromKeyPair({required this.sessionKeyPair})
      : super.fromKey(sessionKeyPair.publicKey, sessionKeyPair.privateKey);

  /// The session key pair used to encrypt and decrypt messages
  final AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> sessionKeyPair;

  /// The public key of the session key pair
  RSAPublicKey get publicKey => sessionKeyPair.publicKey;

  /// The public key of the session key pair, encoded in PEM format
  String get publicKeyString => RSAEncryptor.encodeRSAPublicKeyToPem(publicKey);

  /// Decrypt a message encrypted with the session key pair
  ///
  /// Returns the decrypted message on success, or `null` on failure.
  @override
  String decrypt({required String data, Log? context}) {
    final log = functionStart('decrypt', context);
    return useEncrypter((e) => e.decrypt64(data), log);
  }
}
