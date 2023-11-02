part of '../../encrypt.dart';

/// A class that contains all the methods to encrypt and decrypt data using RSA.
class RSAHandler extends EncryptHandler<RSAEncryptor> with Logging {
  /// The current session with the RSA key pair
  late final session = RSADecryptor();

  /// Get the public key of the session
  String get publicKey => session.publicKeyString;

  @override
  RSAEncryptor createInstance(String key) => RSAEncryptor(key);

  /// Encrypt given [data] using the RSA algorithm.
  ///
  /// The maximum length of [data] is 200.
  /// Everything longer will be truncated.
  @override
  String encrypt({required String data, required String key, Log? context}) {
    final log = functionStart('encrypt', context);
    return getInstance(key, context: log).encrypt(data: data, context: log);
  }

  /// Decrypt given [data] using the RSA algorithm
  /// and the private key of the session.
  @override
  String decrypt({required String data, required String key, Log? context}) =>
      session.decrypt(data: data, context: context);

  @override
  List<int> encryptBinary({
    required List<int> data,
    required String key,
    Log? context,
  }) {
    final log = functionStart('encryptBinary', context);
    return getInstance(key, context: log)
        .encryptBinary(data: data, context: log);
  }

  @override
  List<int> decryptBinary({
    required Uint8List data,
    required String key,
    Log? context,
  }) =>
      session.decryptBinary(data: data, context: context);
}
