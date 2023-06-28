import 'package:crypt/encrypt.dart';
import 'package:test/test.dart';

Future<void> main() async {
  group('Encrypt', () {
    group(
      'rsa',
      onPlatform: {'js': const Skip('Take too long on js')},
      () {
        final key = Encrypt.rsaPublicKey;

        test('should correctly encrypt and decrypt message with rsa', () {
          const message = 'This is a test message';
          final encrypted = Encrypt.encrypt(
            data: message,
            key: key,
            encryption: EncryptionType.rsa,
          );
          final decrypted = Encrypt.decrypt(
            data: encrypted!,
            encryption: EncryptionType.rsa,
          );
          expect(decrypted, message);
          expect(encrypted.length, 2);
        });

        test('should return null on decrypting invalid message', () {
          final invalidMessage = ['This is not a valid encrypted message'];
          final decrypted = Encrypt.decrypt(data: invalidMessage);
          expect(decrypted, isNull);
        });
      },
    );

    group('aes', () {
      const key = 'super strong key with -:- more than 32 characters';

      test('should correctly encrypt and decrypt message with aes', () {
        const message = 'This is a test message';
        final encrypted = Encrypt.encrypt(
          data: message,
          key: key,
          encryption: EncryptionType.aes,
        );
        print(encrypted);
        final decrypted = Encrypt.decrypt(
          data: encrypted!,
          key: key,
          encryption: EncryptionType.aes,
        );
        expect(decrypted, message);
        expect(encrypted.length, 2);
      });

      test('should return null on decrypting invalid message', () {
        final invalidMessage = ['This is not a valid encrypted message'];
        final decrypted = Encrypt.decrypt(
          data: invalidMessage,
          encryption: EncryptionType.aes,
        );
        expect(decrypted, isNull);
      });
    });

    group('ecc', () {
      final key = Encrypt.eccPublicKey;

      test('should correctly encrypt and decrypt message with ecc', () {
        const message = 'This is a test message';
        print(key);
        final encrypted = Encrypt.encrypt(data: message, key: key);
        final decrypted = Encrypt.decrypt(data: encrypted!, key: key);
        expect(decrypted, message);
        expect(encrypted.length, 2);
      });

      test('should return null on decrypting invalid message', () {
        final invalidMessage = ['This is not a valid encrypted message'];
        final decrypted = Encrypt.decrypt(data: invalidMessage);
        expect(decrypted, isNull);
      });
    });
  });
}
