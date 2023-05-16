part of '../../encrypt.dart';

abstract class Encryptor {
  /// When the instance was last used
  DateTime _lastUsed = DateTime.now();

  /// Whether the instance has not been used for a while (5 minutes)
  bool get isExpired => age > 300;

  /// How long the instance has not been used (in seconds)
  int get age => DateTime.now().difference(_lastUsed).inSeconds;

  /// Internal method to update the last used time
  void _updateLastUsed() => _lastUsed = DateTime.now();

  String encrypt({required String data, required Log? context});

  String decrypt({required String data, required Log? context});
}
