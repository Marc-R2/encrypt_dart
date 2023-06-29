part of '../../encrypt.dart';

/// Create a new RSA key pair
AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> generateKeyPair({
  int keySize = 2048,
}) {
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
  final pair = keyGenerator.generateKeyPair();
  return AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>(
    pair.publicKey as RSAPublicKey,
    pair.privateKey as RSAPrivateKey,
  );
}
