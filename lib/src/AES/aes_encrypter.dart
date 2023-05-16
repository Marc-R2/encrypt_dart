part of '../../encrypt.dart';

/// Allow to encrypt and decrypt messages using AES
class AESEncrypter extends Encryptor with Logging {
  /// Create a new AES instance with the given [aesKey].
  AESEncrypter(String aesKey)
      : assert(aesKey.length >= 30, 'Key too short'),
        assert(aesKey.contains('-:-'), 'Expect local/remote key pair') {
    final parts = aesKey.split('-:-');
    final lengths = parts.map((e) => e.length).toList();

    final keyHash = Hash.hmacSha256(aesKey, 'aesKey:$lengths');

    final key = Key.fromUtf8(keyHash.substring(0, 32));

    _encrypter = Encrypter(AES(key));
  }

  final iv = IV.fromLength(16);

  /// The encrypter used to encrypt and decrypt messages
  late final Encrypter _encrypter;

  /// Encrypt a message
  String encrypt({required String data, Log? context}) {
    final log = functionStart('encrypt', context);

    // TODO(Marc-R2): 200 is valid for ASCII. Unicode characters may be longer.
    if (data.length > 200) {
      throw log.exception(title: 'Message is too long to be encrypted');
    }

    try {
      _updateLastUsed();
      return _encrypter.encrypt(data, iv: iv).base64;
    } catch (e) {
      throw log.exception(
        title: 'Error while encrypting message',
        message: '$e',
      );
    }
  }

  /// Decrypt a message
  String decrypt({required String data, Log? context}) {
    final log = functionStart('decrypt', context);

    try {
      _updateLastUsed();
      return _encrypter.decrypt64(data, iv: iv);
    } catch (e) {
      throw log.exception(
        title: 'Error while decrypting message',
        message: '$e',
      );
    }
  }
}
