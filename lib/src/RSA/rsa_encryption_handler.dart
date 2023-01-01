part of '../../encrypt.dart';

/// A class that contains all the methods to encrypt and decrypt data using RSA.
class RSAEncryptionHandler with Logging {
  /// The current session with the RSA key pair
  late final session = RSADecryptor();

  /// The maximum length of a single message that can be encrypted automatically
  int get maxLen => 200;

  /// Get the public key of the session
  String get publicKey => session.publicKeyString;

  /// All instances in memory
  final Map<String, RSAEncryptor> _instances = {};

  /// Get the instance with the given [publicKey].
  ///
  /// If no instance with the given [publicKey] exists,
  /// a new one will be created.
  RSAEncryptor getInstance(String publicKey) {
    if (_instances.containsKey(publicKey)) return _instances[publicKey]!;
    final newInstance = RSAEncryptor(publicKey);
    _instances[publicKey] = newInstance;

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
          title: 'Cleaned RSA instances',
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
  String? encrypt({required String data, String? publicKey}) {
    final log = functionLog('encrypt');
    try {
      if (data.length > maxLen) return null;
      if (publicKey == null) return session.encrypt(data);
      return getInstance(publicKey).encrypt(data);
    } catch (e, trace) {
      log.warn(title: 'Could not encrypt', message: '$e', trace: trace);
      return null;
    }
  }

  /// Decrypt given [data] using the RSA algorithm
  /// and the private key of the session.
  String? decrypt({required String data}) => session.decrypt(data);
}

/// Create a new RSA key pair
AsymmetricKeyPair generateKeyPair({int keySize = 2048}) {
  // Create a new secure random number generator using the Fortuna algorithm
  final rng = Random.secure();
  final seed = KeyParameter(
    Uint8List.fromList(List.generate(32, (_) => rng.nextInt(255))),
  );
  final secureRandom = pc.SecureRandom('Fortuna')..seed(seed);

  // Create RSA key generation parameters with the specified key size
  // and a default exponent of 65537
  final keyParams = RSAKeyGeneratorParameters(
    BigInt.parse('65537'),
    keySize,
    12,
  );

  // Initialize the key generator with the secure random number
  // generator and key generation parameters
  final keyGenerator = KeyGenerator('RSA')
    ..init(ParametersWithRandom(keyParams, secureRandom));

  // Generate the RSA key pair and return it
  return keyGenerator.generateKeyPair();
}
