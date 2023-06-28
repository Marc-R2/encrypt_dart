part of '../encrypt.dart';

/// [Encrypt] handles the encryption and decryption of data.
///
/// Usually, you use the static [encrypt] and [decrypt] methods.
///
/// All other methods are used to by theses methods.
class Encrypt with Logging {
  /// [RSAHandler] instance to perform RSA encryption
  ///
  /// A random RSA key pair is generated on the first use.
  static final RSAHandler rsa = RSAHandler();

  /// [ECCHandler] instance to perform ECC encryption
  ///
  /// A random ECC key pair is generated on the first use.
  static final ECCHandler ecc = ECCHandler();

  /// [AESHandler] instance to perform AES encryption
  ///
  /// The symmetric key have to be provided on each operation call.
  static final AESHandler aes = AESHandler();

  /// PublicKey of the session
  @Deprecated(
    'RSA and ECC have different public keys. '
    'Use rsaPublicKey or eccPublicKey instead.',
  )
  static String get publicKey => rsa.publicKey;

  /// RSA PublicKey of the session
  static String get rsaPublicKey => rsa.publicKey;

  /// ECC PublicKey of the session
  static String get eccPublicKey => ecc.publicKey;

  /// Encrypt given [data] using the
  /// encryption method specified in [encryption].
  ///
  /// The [data] will be split into chunks of [maxLen] characters
  /// to be encrypted individually.
  ///
  /// If you use RSA the [key] should be the public key of the receiver.
  ///
  /// If you use AES the [key] should be the AES key.
  ///
  /// If you use no encryption, the [key] is ignored
  /// and the [data] will be converted to base64.
  static List<String>? encrypt({
    required String data,
    String key = '',
    EncryptionType encryption = EncryptionType.ecc,
  }) {
    // Split the data into equally sized chunks with a max length of [maxLen]
    final chunks = splitIntoBlocks(data, encryption);
    final encryptedChunks = <String>[];

    // Iterate over each chunk and encrypt it
    for (final chunk in chunks) {
      final encryptedChunk = encryptRaw(
        plainText: chunk,
        key: key,
        encryption: encryption,
      );

      // If encryptRaw returns null, return null
      if (encryptedChunk == null) return null;
      encryptedChunks.add(encryptedChunk);
    }

    // Generate a hash of the original chunks
    final hash = blockHash(chunks);
    // If blockHash returns null, return null
    if (hash == null) return null;

    // Add the hash to the end of the list of encrypted chunks
    encryptedChunks.add(hash);

    // Return the list of encrypted chunks
    return encryptedChunks;
  }

  /// Decrypt given chunks of [data] using the
  /// encryption method specified in [encryption].
  ///
  /// If you use RSA the private key of the instance will be used.
  /// [key] is ignored.
  ///
  /// If you use AES the [key] should be the AES key.
  ///
  /// If you use no encryption, the [key] is ignored
  /// and the [data] will be converted from base64.
  static String? decrypt({
    required List<String> data,
    String key = '',
    EncryptionType encryption = EncryptionType.ecc,
  }) {
    final hash = data.last;

    if (!hash.startsWith(hashKey)) {
      Message.warning(
        title: 'Invalid hash',
        text: 'Hash is missing or invalid',
        klasse: 'Encrypt',
        function: 'decrypt',
      );
      return null;
    }

    final decryptedChunks = <String>[];

    for (final chunk in data) {
      if (chunk == hash) continue;

      final decryptedChunk = decryptRaw(
        encryptedText: chunk,
        key: key,
        encryption: encryption,
      );

      if (decryptedChunk == null) return null;

      decryptedChunks.add(decryptedChunk);
    }

    final decrypted = decryptedChunks.join();

    if (blockHash(decryptedChunks) != hash) return null;

    return decrypted;
  }

  /// Splits a given [plainText] into chunks of [maxLen] characters.
  static List<String> splitIntoBlocks(String plainText, EncryptionType type) {
    final maxLen = type.maxLength ?? (plainText.length > 8192 ? 8192 : 1024);

    final blocks = plainText.splitMapJoin(
      RegExp('.{1,$maxLen'),
      onMatch: (m) => '${m.group(0)}\n',
      onNonMatch: (m) => m,
    );

    return blocks.split('\n')
      ..removeWhere((element) => element.isEmpty);
  }

  /// Specifies the start of a hash-chunk
  static const hashKey = '---hash---';

  /// Creates the hash of given [chunks].
  static String? blockHash(List<String> chunks) {
    try {
      chunks.removeWhere((block) => block.startsWith(hashKey));

      final message = chunks.join('-');
      final blockCount = chunks.length;
      final textLength = message.length;
      final mac = '$textLength-$blockCount-${textLength % blockCount}';

      return '$hashKey${Hash.hmacSha512(message, mac)}';
    } catch (e, trace) {
      Message.error(
        title: 'Failed to hash data',
        text: '$e',
        stackTrace: trace,
      );
      return null;
    }
  }

  /// Encrypt given [plainText] using the
  /// encryption method specified in [encryption].
  ///
  /// Note: This method does not split the [plainText] into chunks.
  ///
  /// The maximum length is limited by the [encryption] method
  /// and may fail if the [plainText] is too long.
  static String? encryptRaw({
    required String plainText,
    String key = '',
    EncryptionType encryption = EncryptionType.rsa,
  }) {
    switch (encryption) {
      case EncryptionType.none:
        // TODO(Marc-R2): Base64 encode
        return plainText;
      case EncryptionType.aes:
        return encryptAes(plainText, key);
      case EncryptionType.rsa:
        return encryptRsa(plainText, key);
      case EncryptionType.ecc:
        return encryptEcc(plainText, key);
    }
  }

  /// Encrypt given [plainText] using AES.
  static String? encryptAes(String plainText, String key) =>
      aes.encrypt(data: plainText, key: key);

  /// Encrypt given [plainText] using RSA.
  static String? encryptRsa(String plainText, String key) =>
      rsa.encrypt(data: plainText, key: key);

  /// Encrypt given [plainText] using ECC.
  static String? encryptEcc(String plainText, String key) =>
      ecc.encrypt(data: plainText, key: key);

  /// Decrypt given [encryptedText] using the
  /// encryption method specified in [encryption].
  static String? decryptRaw({
    required String encryptedText,
    String key = '',
    EncryptionType encryption = EncryptionType.rsa,
  }) {
    switch (encryption) {
      case EncryptionType.none:
        // TODO(Marc-R2): Base64 decode
        return encryptedText;
      case EncryptionType.aes:
        return decryptAes(encryptedText, key);
      case EncryptionType.rsa:
        return decryptRsa(encryptedText);
      case EncryptionType.ecc:
        return decryptEcc(encryptedText);
    }
  }

  /// Decrypt given [encryptedText] using AES.
  static String? decryptAes(String encryptedText, String key) =>
      aes.decrypt(data: encryptedText, key: key);

  /// Decrypt given [encryptedText] using RSA.
  static String? decryptRsa(String encryptedText) =>
      rsa.decrypt(data: encryptedText, key: '');

  /// Decrypt given [encryptedText] using ECC.
  static String? decryptEcc(String encryptedText) =>
      ecc.decrypt(data: encryptedText, key: eccPublicKey);
}
