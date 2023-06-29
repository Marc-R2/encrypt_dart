part of '../encrypt.dart';

/// Possible security types for a package.
enum EncryptionType {
  /// No security
  ///
  /// The data will be encoded for transmission and split into chunks.
  none,

  /// Medium security
  ///
  /// The data will be en-/decrypted using AES and a given key.
  ///
  /// The data will be encoded for transmission and split into chunks.
  aes,

  /// High security
  ///
  /// The data will be encrypted using RSA with a given public-key.
  /// For decryption the central private-key will be used.
  ///
  /// The data will be encoded for transmission and split into chunks.
  rsa(maxLength: 200),

  /// High security
  ///
  /// The data will be encrypted using ECC with a given public-key.
  /// For decryption the central private-key will be used.
  ///
  /// The data will be encoded for transmission and split into chunks.
  ecc;

  const EncryptionType({this.maxLength});

  final int? maxLength;
}
