part of '../../encrypt.dart';

/// A class that contains all the methods to encrypt and decrypt data using RSA.
class AESHandler extends EncryptHandler<AESEncrypter> with Logging {
  @override
  AESEncrypter createInstance(String key) => AESEncrypter(key);
}
