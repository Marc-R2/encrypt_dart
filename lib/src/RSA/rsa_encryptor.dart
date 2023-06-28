part of '../../encrypt.dart';

/// Allow to encrypt messages using a RSA public key
class RSAEncryptor extends Encryptor with Logging {
  /// Constructor for RSAEncryptor.
  ///
  /// Initializes the [encrypter] field with the provided [publicKey] by
  /// first parsing the key using RSAKeyParser and then initializing the
  /// [encrypter] with the parsed key.
  RSAEncryptor(String publicKey) {
    final key = RSAKeyParser().parse(_wrapKeyAsPublicKey(publicKey));
    encrypter = Encrypter(RSA(publicKey: key as RSAPublicKey));
  }

  /// Constructor for the parent inheriting the encryption functions
  RSAEncryptor._parent();

  /// The encrypter used to encrypt messages
  late final Encrypter encrypter;

  /// Encrypt a message
  String encrypt({required String data, Log? context}) {
    final log = functionLog('encrypt');

    // TODO(Marc-R2): 200 is valid for ASCII. Unicode characters may be longer.
    if (data.length > 200) {
      throw log.exception(title: 'Message is too long to be encrypted');
    }

    try {
      _updateLastUsed();
      return encrypter.encrypt(data).base64;
    } catch (e) {
      throw log.exception(
        title: 'Error while encrypting message',
        message: '$e',
      );
    }
  }

  /// Enode the given [publicKey] to PEM format using the PKCS#8 standard.
  static String encodeRSAPublicKeyToPem(RSAPublicKey publicKey) {
    // Create an ASN1 sequence for the algorithm identifier
    final algorithmSeq = ASN1Sequence();
    // Create an ASN1 object for the algorithm parameters
    final paramsAsn1Obj = ASN1Object.fromBytes(Uint8List.fromList([0x5, 0x0]));
    // Add the algorithm identifier and parameters to the sequence
    algorithmSeq
      ..add(ASN1ObjectIdentifier.fromName('rsaEncryption'))
      ..add(paramsAsn1Obj);

    // Create an ASN1 sequence for the public key
    final publicKeySeq = ASN1Sequence()
      ..add(ASN1Integer(publicKey.modulus))
      ..add(ASN1Integer(publicKey.exponent));
    // Create an ASN1 bit string from the public key sequence
    final publicKeySeqBitString = ASN1BitString(
      stringValues: Uint8List.fromList(publicKeySeq.encode()),
    );

    // Create the top-level ASN1 sequence containing the algorithm identifier
    // and public key
    final topLevelSeq = ASN1Sequence()
      ..add(algorithmSeq)
      ..add(publicKeySeqBitString);

    // Encode the top-level sequence as a base64 string
    final dataBase64 = base64.encode(topLevelSeq.encode());
    // Split the base64 string into chunks of size 64
    final chunks = chunk(dataBase64, 64);

    // Return the chunks as a single string, separated by newlines
    return chunks.join('\n');
  }

  /// Splits the given String [s] in chunks with the given [chunkSize].
  static List<String> chunk(String s, int chunkSize) {
    // Initialize the list of chunks
    final chunked = <String>[];
    // Iterate through the string by the given chunk size
    for (var i = 0; i < s.length; i += chunkSize) {
      // Determine the end of the current chunk
      // If the end is past the length of the string,
      // use the length of the string
      // Otherwise, use the calculated end
      final end = (i + chunkSize < s.length) ? i + chunkSize : s.length;
      // Add the current chunk to the list
      chunked.add(s.substring(i, end));
    }
    // Return the list of chunks
    return chunked;
  }

  static String _wrapKeyAsPublicKey(String key) {
    return '-----BEGIN PUBLIC KEY-----\r\n$key\r\n-----END PUBLIC KEY-----';
  }

  @override
  String decrypt({required String data, required Log? context}) {
    final log = functionStart('decrypt', context);
    throw log.exception(title: 'RSAEncryptor cannot decrypt messages');
  }
}
