import 'package:elliptic/ecdh.dart';
import 'package:elliptic/elliptic.dart';
import 'package:test/scaffolding.dart';

void main() {
  final curves = [
    getP128(),
    getP224(),
    getP256(),
    getP384(),
    getP521(),
  ];

  for (final ec in curves) {
    group(ec.name, () {
      test('use elliptic curves', () {
        final start = DateTime.now();
        final priv = ec.generatePrivateKey();
        final end = DateTime.now();
        print('generatePrivateKey: ${end.difference(start).inMilliseconds}ms');
        final pub = priv.publicKey;
        print('privateKey: 0x$priv');
        print('publicKey: 0x$pub');
      });

      test('use ecdh', () {
        var privateAlice = ec.generatePrivateKey();
        var publicAlice = privateAlice.publicKey;
        var privateBob = ec.generatePrivateKey();
        var publicBob = privateAlice.publicKey;
        var secretAlice = computeSecretHex(privateAlice, publicBob);
        var secretBob = computeSecretHex(privateBob, publicAlice);
        print('secretAlice: 0x$secretAlice');
        print('secretBob: 0x$secretBob');
      });

      test('repeated aver. time to public key', () {
        final timesKeyPrivate = <Duration>[];
        final timesKeyPublic = <Duration>[];
        final timesKeyTotal = <Duration>[];

        for (var i = 0; i < 2048; i++) {
          final start1 = DateTime.now();
          final key = ec.generatePrivateKey();
          timesKeyPrivate.add(DateTime.now().difference(start1));
          final start2 = DateTime.now();
          key.publicKey;
          final end = DateTime.now();
          timesKeyPublic.add(end.difference(start2));
          timesKeyTotal.add(end.difference(start1));
        }
        final averPrivate = timesKeyPrivate.reduce((a, b) => a + b) ~/ timesKeyPrivate.length;
        final averPublic = timesKeyPublic.reduce((a, b) => a + b) ~/ timesKeyPublic.length;
        final averTotal = timesKeyTotal.reduce((a, b) => a + b) ~/ timesKeyTotal.length;
        print('aver. time: ${averPrivate.inMicroseconds}us private key');
        print('aver. time: ${averPublic.inMicroseconds}us public key');
        print('aver. time: ${averTotal.inMicroseconds}us total');

        // Maximal / minimal time for private, public and total key generation.
        final maxPrivate = timesKeyPrivate.reduce((a, b) => a > b ? a : b);
        final minPrivate = timesKeyPrivate.reduce((a, b) => a < b ? a : b);
        final maxPublic = timesKeyPublic.reduce((a, b) => a > b ? a : b);
        final minPublic = timesKeyPublic.reduce((a, b) => a < b ? a : b);
        final maxTotal = timesKeyTotal.reduce((a, b) => a > b ? a : b);
        final minTotal = timesKeyTotal.reduce((a, b) => a < b ? a : b);

        print('max. time: ${maxPrivate.inMicroseconds}us private key');
        print('min. time: ${minPrivate.inMicroseconds}us private key');
        print('max. time: ${maxPublic.inMicroseconds}us public key');
        print('min. time: ${minPublic.inMicroseconds}us public key');
        print('max. time: ${maxTotal.inMicroseconds}us total');
        print('min. time: ${minTotal.inMicroseconds}us total');
      });
    });
  }
}
