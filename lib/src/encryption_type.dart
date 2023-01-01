part of '../encrypt.dart';

/// Possible security types for a package.
enum EncryptionType {
  /// No security. The data in the package payload is not encrypted.
  none,
  /// Medium security. The data in the package payload is encrypted using the
  /// previously agreed password. This password is sent in the handshake.
  /// The minimum password length is 128 characters.
  aes,
  /// High security. The data in the package payload is encrypted using the
  /// public key of the destination. The public key is sent in the handshake.
  rsa,
}
