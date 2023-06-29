import 'package:crypt/encrypt.dart';
import 'package:log_message/logger.dart';
import 'package:test/test.dart';

void main() {
  group('RSAEncryptionHandler', () {
    late RSAHandler rsaEncryptionHandler;
    late String publicKey;

    setUp(() {
      rsaEncryptionHandler = RSAHandler();
      publicKey = rsaEncryptionHandler.publicKey;
    });

    test('encrypt', () {
      const message = 'This is a test message';
      final encryptedMessage = rsaEncryptionHandler.encrypt(
        data: message,
        key: publicKey,
      );
      expect(encryptedMessage, isNotNull);
      expect(encryptedMessage, isNotEmpty);
      expect(encryptedMessage, isNot(message));
    });

    test('encrypt with message length greater than maxLen should throw', () {
      // Gen a 1024 character string
      final message = List.generate(1024, (n) => '$n').join();
      expect(
        () => rsaEncryptionHandler.encrypt(
          data: message,
          key: publicKey,
        ),
        throwsA(isA<ErrorMessage>()),
      );
    });
  });
}
