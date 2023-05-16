part of '../../encrypt.dart';

/// A class that contains all the methods to encrypt and decrypt data using RSA.
class AESHandler extends EncryptHandler<AESEncrypter> with Logging {
  /// The maximum length of a single message that can be encrypted automatically
  int get maxLen => 200;

  @override
  AESEncrypter createInstance(String key) => AESEncrypter(key);
}
