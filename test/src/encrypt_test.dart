import 'package:crypt/encrypt.dart';
import 'package:test/test.dart';

Future<void> main() async {
  group('Encrypt', () {
    final key = Encrypt.publicKey;

    test('should correctly encrypt and decrypt message', () {
      const message = 'This is a test message';
      final encrypted = Encrypt.encrypt(data: message, key: key);
      final decrypted = Encrypt.decrypt(data: encrypted!);
      expect(decrypted, message);
      expect(encrypted.length, 2);
    });

    test('should return null on decrypting invalid message', () {
      final invalidMessage = ['This is not a valid encrypted message'];
      final decrypted = Encrypt.decrypt(data: invalidMessage);
      expect(decrypted, isNull);
    });
  });
}
