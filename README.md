# Crypt / Encrypt Dart

[![codecov](https://codecov.io/gh/Marc-R2/encrypt_dart/branch/master/graph/badge.svg?token=YPB1NXNT7U)](https://codecov.io/gh/Marc-R2/encrypt_dart)

## Installation

Simply make sure to add the following to your `pubspec.yaml`:

```yaml
dependencies:
  crypt:
    git:
      url: https://github.com/Marc-R2/encrypt_dart.git
```

and run `pub get` or `pub upgrade` in the same directory as your `pubspec.yaml`.

## Quick Start

```dart
import 'package:crypt/encrypt.dart';
```

### Hashing

```dart
final hashed = Hash.sha256('Hello, World!').hashString; // or hashBytes or hashDig
```

### Encrypting
```dart
final instance = AESHandler(); // or RSAHandler or ECCHandler
final encrypted = instance.encrypt(key: '<key>', data: 'Hello, World!');
final decrypted = instance.decrypt(encrypted);
```

### Signing (only with ECCHandler)
```dart
final sign = ECCHandler.signData(privateKey: '<private key>', data: 'Hello, World!');
final verify = ECCHandler.verifyData(publicKey: '<public key>', data: 'Hello, World!', signature: sign);
```

