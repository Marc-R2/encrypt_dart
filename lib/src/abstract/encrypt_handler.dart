part of '../../encrypt.dart';

abstract class EncryptHandler<T extends Encryptor> with Logging {
  /// All instances in memory
  final Map<String, T> _instances = {};

  int get instanceCount => _instances.length;

  T createInstance(String key);

  /// Get the instance with the given [key].
  ///
  /// If no instance with the given [key] exists,
  /// a new one will be created.
  T getInstance(String key, {Log? context}) {
    final log = functionStart('getInstance', context);
    if (_instances.containsKey(key)) return _instances[key]!;
    final newInstance = _instances[key] = createInstance(key);
    cleanInstances(context: log);
    return newInstance;
  }

  /// Remove all instances that are not used anymore.
  void cleanInstances({int targetCount = 128, required Log? context}) {
    final log = functionStart('cleanInstances', context);
    final len = _instances.length;
    if (len < targetCount * 2) return;

    // Remove the oldest half of instances if they have been expired
    final sortedInstances = _instances.entries.toList()
      ..sort((a, b) => a.value.age.compareTo(b.value.age));

    final expiredInstances =
        sortedInstances.where((element) => element.value.isExpired).toList();

    final expiredCount = expiredInstances.length;
    if (expiredCount < targetCount) return;

    for (final element in expiredInstances.sublist(0, targetCount)) {
      _instances.remove(element.key);
    }

    log.info(
      title: 'Cleaned instances in {type}',
      message: 'Reduced from {len} to {current} with {expired} '
          'expired instances and {target} target count',
      values: {
        'type': runtimeType.toString(),
        'len': len,
        'current': _instances.length,
        'expired': expiredCount,
        'target': targetCount,
      },
    );
  }

  /// Encrypt given [data] using the RSA algorithm.
  ///
  /// Everything longer will be truncated.
  String encrypt({required String data, required String key, Log? context}) {
    final log = functionStart('encrypt', context);
    return getInstance(key).encrypt(data: data, context: log);
  }

  List<int> encryptBinary({
    required List<int> data,
    required String key,
    Log? context,
  }) {
    final log = functionStart('encryptBinary', context);
    return getInstance(key).encryptBinary(data: data, context: log);
  }

  /// Decrypt given [data] using the RSA algorithm
  /// and the private key of the session.
  String decrypt({required String data, required String key, Log? context}) {
    final log = functionStart('decrypt', context);
    return getInstance(key).decrypt(data: data, context: log);
  }

  List<int> decryptBinary({
    required Uint8List data,
    required String key,
    Log? context,
  }) {
    final log = functionStart('decryptBinary', context);
    return getInstance(key).decryptBinary(data: data, context: log);
  }
}
