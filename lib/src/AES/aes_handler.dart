part of '../../encrypt.dart';

/// A class that contains all the methods to encrypt and decrypt data using RSA.
class AESHandler extends EncryptHandler<AESEncrypter> with Logging {
  /// The maximum length of a single message that can be encrypted automatically
  int get maxLen => 200;

  @override
  AESEncrypter createInstance(String key) => AESEncrypter(key);

  /// Encrypt given [data] using the RSA algorithm.
  ///
  /// The maximum length of [data] is [maxLen].
  /// Everything longer will be truncated.
  String? encrypt({required String data, required String aesKey}) {
    final log = functionLog('encrypt');
    try {
      if (data.length > maxLen) return null;
      return createInstance(aesKey).encrypt(data);
    } catch (e, trace) {
      log.warn(title: 'Could not encrypt', message: '$e', trace: trace);
      return null;
    }
  }

  /// Decrypt given [data] using the RSA algorithm
  /// and the private key of the session.
  String? decrypt({required String data, required String aesKey}) {
    final log = functionLog('encrypt');
    try {
      return createInstance(aesKey).decrypt(data);
    } catch (e, trace) {
      log.warn(title: 'Could not encrypt', message: '$e', trace: trace);
      return null;
    }
  }
}
