part of '../../encrypt.dart';

/// A class that contains all the methods to encrypt and decrypt data using RSA.
class AESHandler with Logging {
  /// The maximum length of a single message that can be encrypted automatically
  int get maxLen => 200;

  /// All instances in memory
  final Map<String, AESEncrypter> _instances = {};

  /// Get the instance with the given [aesKey].
  ///
  /// If no instance with the given [aesKey] exists,
  /// a new one will be created.
  AESEncrypter getInstance(String aesKey) {
    if (_instances.containsKey(aesKey)) return _instances[aesKey]!;
    final newInstance = AESEncrypter(aesKey);
    _instances[aesKey] ??= newInstance;

    cleanInstances();

    return newInstance;
  }

  /// Remove all instances that are not used anymore.
  void cleanInstances({int targetCount = 128}) {
    final log = functionLog('cleanInstances');
    final len = _instances.length;
    if (len > targetCount * 2) {
      // Remove the oldest half of instances if they have been expired
      final sortedInstances = _instances.entries.toList()
        ..sort((a, b) => a.value.age.compareTo(b.value.age));

      final expiredInstances =
          sortedInstances.where((element) => element.value.isExpired).toList();

      final expiredCount = expiredInstances.length;

      if (expiredCount > targetCount) {
        expiredInstances.sublist(0, targetCount).forEach(
              (element) => _instances.remove(element.key),
            );

        log.info(
          title: 'Cleaned AES instances',
          message: 'Reduced from {len} to {current} with {expired} '
              'expired instances and {target} target count',
          values: {
            'len': len,
            'current': _instances.length,
            'expired': expiredCount,
            'target': targetCount,
          },
        );
      }
    }
  }

  /// Encrypt given [data] using the RSA algorithm.
  ///
  /// The maximum length of [data] is [maxLen].
  /// Everything longer will be truncated.
  String? encrypt({required String data, required String aesKey}) {
    final log = functionLog('encrypt');
    try {
      if (data.length > maxLen) return null;
      return getInstance(aesKey).encrypt(data);
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
      return getInstance(aesKey).decrypt(data);
    } catch (e, trace) {
      log.warn(title: 'Could not encrypt', message: '$e', trace: trace);
      return null;
    }
  }
}
