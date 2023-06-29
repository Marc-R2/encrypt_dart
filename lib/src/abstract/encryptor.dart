part of '../../encrypt.dart';

abstract class Encryptor with Logging {
  Encryptor(this._algorithm);

  final Algorithm _algorithm;

  late final _encrypter = Encrypter(_algorithm);

  /// When the instance was last used
  DateTime _lastUsed = DateTime.now();

  /// Whether the instance has not been used for a while
  bool get isExpired => age > expireTime;

  static int expireTime = 300;

  /// How long the instance has not been used (in seconds)
  int get age => DateTime.now().difference(_lastUsed).inSeconds;

  /// Internal method to update the last used time
  void _updateLastUsed() => _lastUsed = DateTime.now();

  String encrypt({required String data, required Log? context});

  String decrypt({required String data, required Log? context});

  String useEncrypter(String Function(Encrypter e) f, Log? context) {
    final log = functionStart('useEncrypter', context);
    try {
      _updateLastUsed();
      return f(_encrypter);
    } catch (e) {
      throw log.exception(
        title: 'Error while using encrypter',
        message: '$e',
      );
    }
  }
}
