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

  /// Encrypt given [data] using the ECC algorithm.
  @override
  String encrypt({required String data, required String key, Log? context}) =>
      getInstance(key).encrypt(data: data, context: context);

  /// Decrypt given [data] using the ECC algorithm
  /// and the private key of the session.
  @override
  String decrypt({required String data, required String key, Log? context}) =>
      getInstance(key).decrypt(data: data, context: context);
}
