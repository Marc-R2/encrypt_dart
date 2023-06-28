part of '../../encrypt.dart';

/// A class that contains all the methods to encrypt and decrypt data using ECC.
class ECCHandler extends EncryptHandler<ECCEncryptor> with Logging {
  /// The current session with the ECC key pair
  late final session = ECCDecryptor();

  /// The maximum length of a single message that can be encrypted automatically
  int get maxLen => 200;

  /// Get the public key of the session
  String get publicKey => session.publicKeyString;

  @override
  ECCEncryptor createInstance(String key) => ECCEncryptor(key, session);

  /// Encrypt given [data] using the ECC algorithm.
  ///
  /// The maximum length of [data] is [maxLen].
  /// Everything longer will be truncated.
  @override
  String encrypt({required String data, String? key, Log? context}) {
    if (key == null) return session.encrypt(data: data, context: context);
    return getInstance(key).encrypt(data: data, context: context);
  }

  /// Decrypt given [data] using the ECC algorithm
  /// and the private key of the session.
  @override
  String decrypt({required String data, required String key, Log? context}) =>
      session.decrypt(data: data, context: context);
}
