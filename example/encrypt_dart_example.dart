import 'package:crypt/encrypt.dart';

void main() {
  final encrypted = Encrypt.encrypt(data: 'This is a test message');
  print(encrypted);

  final decrypted = Encrypt.decrypt(data: encrypted!);
  print(decrypted);
}
