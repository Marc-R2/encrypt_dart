part of '../../encrypt.dart';

/// Allow to encrypt and decrypt messages using a RSA key pair
class RSADecryptor extends RSAEncryptor {
  /// Constructor for RSADecryptor.
  ///
  /// Initializes the [encrypter] field with a new RSA key pair.
  RSADecryptor() : super._parent();

  /// The session key pair used to encrypt and decrypt messages
  late final sessionKeyPair = generateKeyPair();

  /// The public key of the session key pair
  RSAPublicKey get publicKey => sessionKeyPair.publicKey as RSAPublicKey;

  /// The private key of the session key pair
  RSAPrivateKey get _privateKey => sessionKeyPair.privateKey as RSAPrivateKey;

  /// The public key of the session key pair, encoded in PEM format
  String get publicKeyString => RSAEncryptor.encodeRSAPublicKeyToPem(publicKey);

  /// The encrypter used to encrypt and decrypt messages
  @override
  late final encrypter = Encrypter(
    RSA(
      publicKey: publicKey,
      privateKey: _privateKey,
    ),
  );

  /// Decrypt a message encrypted with the session key pair
  ///
  /// Returns the decrypted message on success, or `null` on failure.
  String decrypt({required String data, Log? context}) {
    final log = functionStart('decrypt', context);
    try {
      _updateLastUsed();
      return encrypter.decrypt64(data);
    } catch (e) {
      throw log.exception(
        title: 'Error while decrypting message',
        message: '$e',
      );
    }
  }
}
