part of '../../encrypt.dart';

/// Allow to encrypt and decrypt messages using AES
class AESEncrypter with Logging {
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

  /// When the instance was last used
  DateTime _lastUsed = DateTime.now();

  /// Whether the instance has not been used for a while (5 minutes)
  bool get isExpired => age > 300;

  /// How long the instance has not been used (in seconds)
  int get age => DateTime.now().difference(_lastUsed).inSeconds;

  /// Internal method to update the last used time
  void _updateLastUsed() => _lastUsed = DateTime.now();

  /// Encrypt a message
  String? encrypt(String message) {
    final log = functionLog('encrypt');

    // TODO(Marc-R2): 200 is valid for ASCII. Unicode characters may be longer.
    if (message.length > 200) {
      log.warn(title: 'Message is too long to be encrypted');
      return null;
    }

    try {
      _updateLastUsed();
      return _encrypter.encrypt(message, iv: iv).base64;
    } catch (e) {
      log.error(title: 'Error while encrypting message', message: '$e');
      return null;
    }
  }

  /// Decrypt a message
  String? decrypt(String message) {
    final log = functionLog('decrypt');

    try {
      _updateLastUsed();
      return _encrypter.decrypt64(message, iv: iv);
    } catch (e) {
      log.error(title: 'Error while decrypting message', message: '$e');
      return null;
    }
  }
}
