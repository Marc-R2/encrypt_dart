import 'package:crypt/encrypt.dart';
import 'package:test/test.dart';

void main() {
  group('AESEncrypter', () {
    const key = 'abcdefghijklmnopq-:-rstuvwxyz0123456789';

    test('encrypt and decrypt', () {
      final instance = AESEncrypter(key);
      final message = 'The quick brown fox jumps over the lazy dog.' * 2;
      final encrypted = instance.encrypt(data: message);
      expect(encrypted, isNotNull);
      expect(encrypted, isNot(equals(message)));
      final decrypted = instance.decrypt(data: encrypted);
      expect(decrypted, equals(message));
    });

    test('encrypt long message', () {
      final instance = AESEncrypter(key);
      final message = 'The quick brown fox jumps over the lazy dog. ' * 20;
      final encrypted = instance.encrypt(data: message);
      expect(encrypted, hasLength(greaterThan(message.length)));
    });

    test('encrypt and decrypt with special characters', () {
      final instance = AESEncrypter(key);
      const message = r'!@#$%^&*()_+-=[]{};:\",.<>/?\\|';
      final encrypted = instance.encrypt(data: message);
      expect(encrypted, isNotNull);
      expect(encrypted, isNot(equals(message)));
      final decrypted = instance.decrypt(data: encrypted);
      expect(decrypted, equals(message));
    });
  });
}
