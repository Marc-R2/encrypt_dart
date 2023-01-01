import 'package:crypt/encrypt.dart';
import 'package:test/test.dart';

void main() {
  group('RSAEncryptionHandler', () {
    late RSAEncryptionHandler rsaEncryptionHandler;
    late String publicKey;

    setUp(() {
      rsaEncryptionHandler = RSAEncryptionHandler();
      publicKey = rsaEncryptionHandler.publicKey;
    });

    test('encrypt', () {
      const message = 'This is a test message';
      final encryptedMessage = rsaEncryptionHandler.encrypt(
        data: message,
        publicKey: publicKey,
      );
      expect(encryptedMessage, isNotNull);
      expect(encryptedMessage, isNotEmpty);
      expect(encryptedMessage, isNot(message));
    });

    test('encrypt with message length greater than maxLen', () {
      // Gen a 1024 character string
      final message = List.generate(1024, (n) => '$n').join();
      final encryptedMessage = rsaEncryptionHandler.encrypt(
        data: message,
        publicKey: publicKey,
      );
      expect(encryptedMessage, isNull);
    });
  });
}
