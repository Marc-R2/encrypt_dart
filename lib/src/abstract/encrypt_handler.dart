part of '../../encrypt.dart';

abstract class EncryptHandler<T extends Encryptor> with Logging {
  /// All instances in memory
  final Map<String, T> _instances = {};

  T createInstance(String key);

  /// Get the instance with the given [key].
  ///
  /// If no instance with the given [key] exists,
  /// a new one will be created.
  T getInstance(String key) {
    if (_instances.containsKey(key)) return _instances[key]!;
    final newInstance = createInstance(key);
    _instances[key] ??= newInstance;

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
}
