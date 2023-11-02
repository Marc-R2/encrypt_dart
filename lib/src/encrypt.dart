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

  /// RSA PublicKey of the session
  static String get rsaPublicKey => rsa.publicKey;

  /// ECC PublicKey of the session
  static String get eccPublicKey => ecc.publicKey;

  /// Encrypt given [data] using the
  /// encryption method specified in [encryption].
  ///
  /// The [data] will be split into chunks when it is (too) long.
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
    final chunks = splitIntoBlocks(data, encryption);
    final encryptedChunks = <String>[];

    for (final chunk in chunks) {
      final encryptedChunk = encryptRaw(
        plainText: chunk,
        key: key,
        encryption: encryption,
      );

      if (encryptedChunk == null) return null;
      encryptedChunks.add(encryptedChunk);
    }

    return encryptedChunks..add(blockHash(chunks));
  }

  static List<int> encryptBinary ({
    required List<int> data,
    String key = '',
    EncryptionType encryption = EncryptionType.ecc,
  }) {
    switch (encryption) {
      case EncryptionType.none:
      // TODO(Marc-R2): Base64 encode
        return data;
      case EncryptionType.aes:
        throw UnimplementedError();
      case EncryptionType.rsa:
        throw UnimplementedError();
      case EncryptionType.ecc:
        return ecc.encryptBinary(data: data, key: key);
    }
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
  @TestGen()
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
        sourceFunction: 'decrypt',
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

  static List<int> decryptBinary ({
    required Uint8List data,
    String key = '',
    EncryptionType encryption = EncryptionType.ecc,
  }) {
    switch (encryption) {
      case EncryptionType.none:
        return data;
      case EncryptionType.aes:
      case EncryptionType.rsa:
        throw UnimplementedError();
      case EncryptionType.ecc:
        return ecc.decryptBinary(data: data, key: key);
    }
  }

  /// Splits a given [plainText] into chunks
  @TestGen()
  static List<String> splitIntoBlocks(String plainText, EncryptionType type) {
    final maxLen = type.maxLength ?? (plainText.length > 8192 ? 8192 : 1024);

    final blocks = plainText.splitMapJoin(
      RegExp('.{1,$maxLen}'),
      onMatch: (m) => '${m.group(0)}\n',
      onNonMatch: (m) => m,
    );

    return blocks.split('\n')
      ..removeWhere((element) => element.isEmpty);
  }

  /// Specifies the start of a hash-chunk
  static const hashKey = '---hash---';

  /// Creates the hash of given [chunks].
  static String blockHash(List<String> chunks) {
    chunks.removeWhere((block) => block.startsWith(hashKey));

    final message = chunks.join('-');
    final blockCount = chunks.length;
    final textLength = message.length;
    final mac = '$textLength-$blockCount-${textLength % blockCount}';

    return '$hashKey${Hash.hmacSha512(message, mac)}';
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
        return aes.encrypt(data: plainText, key: key);
      case EncryptionType.rsa:
        return rsa.encrypt(data: plainText, key: key);
      case EncryptionType.ecc:
        return ecc.encrypt(data: plainText, key: key);
    }
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
        return aes.decrypt(data: encryptedText, key: key);
      case EncryptionType.rsa:
        return rsa.decrypt(data: encryptedText, key: '');
      case EncryptionType.ecc:
        return ecc.decrypt(data: encryptedText, key: key);
    }
  }
}
