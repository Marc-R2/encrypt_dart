part of '../encrypt.dart';

/// [Encrypt] handles the encryption and decryption of data.
///
/// Usually, you use the static [encrypt] and [decrypt] methods.
///
/// All other methods are used to by theses methods.
class Encrypt with Logging {
  /// [RSAEncryptionHandler] instance to perform RSA encryption
  ///
  /// A random RSA key pair is generated on the first use.
  static final RSAEncryptionHandler rsa = RSAEncryptionHandler();

  /// The maximum length of a single message that can be encrypted automatically
  static int get maxLen => rsa.maxLen; // min(rsa.maxLen, aes.maxLen);

  static String get publicKey => rsa.publicKey;

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
    EncryptionType encryption = EncryptionType.rsa,
  }) {
    // Split the data into equally sized chunks with a max length of [maxLen]
    final chunks = splitIntoBlocks(data);
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
    EncryptionType encryption = EncryptionType.rsa,
  }) {
    // Extract the hash value from the end of the data list
    final hash = data.last;

    // Check if the hash value is available (starts with the hashKey prefix)
    if (!hash.startsWith(hashKey)) {
      Message.warning(
        title: 'Invalid hash',
        text: 'Hash is missing or invalid',
        klasse: 'Encrypt',
        function: 'decrypt',
      );
      return null;
    }

    // Initialize a list to store the decrypted chunks
    final decryptedChunks = <String>[];

    // Decrypt each chunk of data in the list
    for (final chunk in data) {
      // Skip the hash value
      if (chunk == hash) continue;

      final decryptedChunk = decryptRaw(
        encryptedText: chunk,
        key: key,
        encryption: encryption,
      );

      // Return null if any chunk fails to decrypt
      if (decryptedChunk == null) return null;

      // Add the decrypted chunk to the list
      decryptedChunks.add(decryptedChunk);
    }

    // Join the decrypted chunks into a single string
    final decrypted = decryptedChunks.join();

    // Check if the hash value of the decrypted data matches
    // the original hash value
    if (blockHash(decryptedChunks) != hash) return null;

    // Return the decrypted data if the hash values match
    return decrypted;
  }

  /// Splits a given [plainText] into chunks of [maxLen] characters.
  static List<String> splitIntoBlocks(String plainText) {
    // Split the plainText string into a list of strings,
    // each of which has a max length of [maxLen]
    // and is separated by a newline character.
    final blocks = plainText.splitMapJoin(
      // Use a regular expression to match chunks of [maxLen] characters
      RegExp('.{1,$maxLen}'),
      // For each match, return the matched string followed
      // by a newline character
      onMatch: (m) => '${m.group(0)}\n',
      // For each non-match, return the non-match as-is
      onNonMatch: (m) => m,
    );

    // Split the blocks string into a list of strings using
    // the newline character as the delimiter
    final blockList = blocks.split('\n')
      // Remove any empty strings from the list
      ..removeWhere((element) => element.isEmpty);

    // Return the list of blocks
    return blockList;
  }

  /// Specifies the start of a hash-chunk
  static const hashKey = '---hash---';

  /// Creates the hash of given [chunks].
  static String? blockHash(List<String> chunks) {
    try {
      // Remove all blocks starting with [hashKey]
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
    }
  }

  /// Encrypt given [plainText] using AES.
  static String? encryptAes(String plainText, String key) {
    // TODO(Marc-R2): Implement
    return plainText;
  }

  /// Encrypt given [plainText] using RSA.
  static String? encryptRsa(String plainText, String key) {
    return rsa.encrypt(data: plainText, publicKey: key);
  }

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
    }
  }

  /// Decrypt given [encryptedText] using AES.
  static String? decryptAes(String encryptedText, String key) {
    // TODO(Marc-R2): Implement
    return encryptedText;
  }

  /// Decrypt given [encryptedText] using RSA.
  static String? decryptRsa(String encryptedText) {
    return rsa.decrypt(data: encryptedText);
  }
}
