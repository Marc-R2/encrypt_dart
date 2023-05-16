part of '../../encrypt.dart';

/// A class that contains all the methods to encrypt and decrypt data using RSA.
class RSAEncryptionHandler extends EncryptHandler<RSAEncryptor> with Logging {
  /// The current session with the RSA key pair
  late final session = RSADecryptor();

  /// The maximum length of a single message that can be encrypted automatically
  int get maxLen => 200;

  /// Get the public key of the session
  String get publicKey => session.publicKeyString;

  @override
  RSAEncryptor createInstance(String key) => RSAEncryptor(key);

  /// Encrypt given [data] using the RSA algorithm.
  ///
  /// The maximum length of [data] is [maxLen].
  /// Everything longer will be truncated.
  @override
  String encrypt({required String data, String? key}) {
    final log = functionStart('encrypt');
    if (key == null) return session.encrypt(data: data, context: log);
    return getInstance(key).encrypt(data: data, context: log);
  }

  /// Decrypt given [data] using the RSA algorithm
  /// and the private key of the session.
  @override
  String decrypt({required String data, required String key}) =>
      session.decrypt(data: data);
}
