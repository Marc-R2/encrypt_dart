part of '../../encrypt.dart';

/// Create a new RSA key pair
AsymmetricKeyPair generateKeyPair({int keySize = 2048}) {
  TimeDebugger.indent('generateKeyPair');
  // Create a new secure random number generator using the Fortuna algorithm
  final rng = Random.secure();
  TimeDebugger.marker('1');
  final seed = KeyParameter(
    Uint8List.fromList(List.generate(32, (_) => rng.nextInt(255))),
  );
  TimeDebugger.marker('2');
  final secureRandom = pc.SecureRandom('Fortuna')..seed(seed);
  TimeDebugger.marker('3');
  // Create RSA key generation parameters with the specified key size
  // and a default exponent of 65537
  final keyParams = RSAKeyGeneratorParameters(
    BigInt.parse('65537'),
    keySize,
    12,
  );
  TimeDebugger.marker('4');
  // Initialize the key generator with the secure random number
  // generator and key generation parameters
  final keyGenerator = RSAKeyGenerator()
    ..init(ParametersWithRandom(keyParams, secureRandom));
  TimeDebugger.marker('5');
  // Generate the RSA key pair and return it
  final pair = keyGenerator.generateKeyPair();
  TimeDebugger.marker('6');
  TimeDebugger.unindent();
  return pair;
}
