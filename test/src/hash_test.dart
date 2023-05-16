import 'package:crypt/encrypt.dart';
import 'package:test/test.dart';

void main() {
  group('Hash', () {
    group('sha1', () {
      test('Hello World', () {
        final hash = Hash.sha1('Hello World');
        print(hash);
        expect(hash, '0a4d55a8d778e5022fab701977c5d840bbc486d0');
      });

      test('Hello World!', () {
        final hash = Hash.sha1('Hello World!');
        print(hash);
        expect(hash, '2ef7bde608ce5404e97d5f042f95f89f1c232871');
      });

      test('BitBot - COM', () {
        final hash = Hash.sha1('BitBot - COM');
        print(hash);
        expect(hash, '6b062511d811fd31e804c973c02ed69c202596c5');
      });

      test('BitBot - COM!', () {
        final hash = Hash.sha1('BitBot - COM!');
        print(hash);
        expect(hash, '9e2777466eadb0d7cf9ff380402e7e187c91a537');
      });
    });

    group('sha224', () {
      test('Hello World', () {
        final sha = Hash.sha224('Hello World');
        print(sha);
        expect(sha, 'c4890faffdb0105d991a461e668e276685401b02eab1ef4372795047');
      });

      test('Hello World!', () {
        final sha = Hash.sha224('Hello World!');
        print(sha);
        expect(sha, '4575bb4ec129df6380cedde6d71217fe0536f8ffc4e18bca530a7a1b');
      });

      test('BitBot - COM', () {
        final sha = Hash.sha224('BitBot - COM');
        print(sha);
        expect(sha, 'ce5283bf902d6d71668ebc90e98c14caf11ddb82e191dfb5f8e73b94');
      });

      test('BitBot - COM!', () {
        final sha = Hash.sha224('BitBot - COM!');
        print(sha);
        expect(sha, '88a836343d87aaf4e2b39887226b0dc80aaf547871871c1e4c050742');
      });
    });

    group('sha256', () {
      test('Hello World', () {
        final sha = Hash.sha256('Hello World');
        print(sha);
        expect(
          sha,
          'a591a6d40bf420404a011733cfb7b190d62c65bf0bcda32b57b277d9ad9f146e',
        );
      });

      test('Hello World!', () {
        final sha = Hash.sha256('Hello World!');
        print(sha);
        expect(
          sha,
          '7f83b1657ff1fc53b92dc18148a1d65dfc2d4b1fa3d677284addd200126d9069',
        );
      });

      test('BitBot - COM', () {
        final sha = Hash.sha256('BitBot - COM');
        print(sha);
        expect(
          sha,
          'dbd1bc81e6f1c6a6d73d5a6d93d827f2aa1ee432db540ad44f98f6ae4b94e613',
        );
      });

      test('BitBot - COM!', () {
        final sha = Hash.sha256('BitBot - COM!');
        print(sha);
        expect(
          sha,
          '7879d3b2934e1075c8ec15ce1610d5a54983bf15bb993749739f5a5ec466fb2b',
        );
      });
    });

    group('sha384', () {
      test('Hello World', () {
        final sha = Hash.sha384('Hello World');
        print(sha);
        expect(
          sha,
          '99514329186b2f6ae4a1329e7ee6c610a7296363351'
          '74ac6b740f9028396fcc803d0e93863a7c3d90f86beee782f4f3f',
        );
      });

      test('Hello World!', () {
        final sha = Hash.sha384('Hello World!');
        print(sha);
        expect(
          sha,
          'bfd76c0ebbd006fee583410547c1887b0292be76d582d96'
          'c242d2a792723e3fd6fd061f9d5cfd13b8f961358e6adba4a',
        );
      });

      test('BitBot - COM', () {
        final sha = Hash.sha384('BitBot - COM');
        print(sha);
        expect(
          sha,
          'c7e4a9fc21fe9a8366d067d8268e3a7c26a65a01a5168f0a'
          'de44b9abed0e039b7428d39521534edd3b3fe5e6d6567a00',
        );
      });

      test('BitBot - COM!', () {
        final sha = Hash.sha384('BitBot - COM!');
        print(sha);
        expect(
          sha,
          'f8d200dc73f89cfb173209aa2b124417bf661df20f38fbd1a'
          'e2466f1dd04994df19e5890164130efebe0b9c05707bb0c',
        );
      });
    });

    group('sha512', () {
      test('Hello World', () {
        final sha = Hash.sha512('Hello World');
        print(sha);
        expect(
          sha,
          '2c74fd17edafd80e8447b0d46741ee243b7eb74dd2149a0ab1b9246fb30382f27e8'
          '53d8585719e0e67cbda0daa8f51671064615d645ae27acb15bfb1447f459b',
        );
      });

      test('Hello World!', () {
        final sha = Hash.sha512('Hello World!');
        print(sha);
        expect(
          sha,
          '861844d6704e8573fec34d967e20bcfef3d424cf48be04e6dc08f2bd58c7297433'
          '71015ead891cc3cf1c9d34b49264b510751b1ff9e537937bc46b5d6ff4ecc8',
        );
      });

      test('BitBot - COM', () {
        final sha = Hash.sha512('BitBot - COM');
        print(sha);
        expect(
          sha,
          'fca3a254a3a04424351526351fe9e8601187d17f63723f4934dcda3f33d69023a0a'
          'e7c6d969fca112dea566654796f9ec6032b997e70c47b7d93c3ca47d7684d',
        );
      });

      test('BitBot - COM!', () {
        final sha = Hash.sha512('BitBot - COM!');
        print(sha);
        expect(
          sha,
          '751753581831b151dadd8729e87a0d16dddb6cbfdabb271397a4780611fe3a97641'
          '343072479d397920a0bd9fe22d220b4fef35e2cede404cd93fb5baa201232',
        );
      });
    });

    group('md5', () {
      test('Hello World', () {
        final md5 = Hash.md5('Hello World');
        print(md5);
        expect(md5, 'b10a8db164e0754105b7a99be72e3fe5');
      });

      test('Hello World!', () {
        final md5 = Hash.md5('Hello World!');
        print(md5);
        expect(md5, 'ed076287532e86365e841e92bfc50d8c');
      });

      test('BitBot - COM', () {
        final md5 = Hash.md5('BitBot - COM');
        print(md5);
        expect(md5, '635372c9292116c1bdcb5f06033b9a4c');
      });

      test('BitBot - COM!', () {
        final md5 = Hash.md5('BitBot - COM!');
        print(md5);
        expect(md5, '5a46aed3404eb117b34e70df86dcdef3');
      });
    });

    group('hmac/sha1', () {
      test('Hello World / A', () {
        final hmac = Hash.hmacSha1('Hello World', 'A');
        print(hmac);
        expect(hmac, 'e22d9d5349192fb2ee683c13ab0ca0ec85a3f7dc');
      });

      test('Hello World / B', () {
        final hmac = Hash.hmacSha1('Hello World', 'B');
        print(hmac);
        expect(hmac, '3c908b7cc9328f58ce83743a1362a2abb9a6223c');
      });

      test('Hello World / C', () {
        final hmac = Hash.hmacSha1('Hello World', 'C');
        print(hmac);
        expect(hmac, 'e28f57696eef79c93cca75afedda87c208eeae2d');
      });

      test('Hello World! / A', () {
        final hmac = Hash.hmacSha1('Hello World!', 'A');
        print(hmac);
        expect(hmac, 'ea5f2362e78ead7e1abcff06ed46ce494d567ebb');
      });

      test('Hello World! / B', () {
        final hmac = Hash.hmacSha1('Hello World!', 'B');
        print(hmac);
        expect(hmac, 'cea13559b4f2254e6641d4e8fefce9a1dd508d98');
      });

      test('Hello World! / C', () {
        final hmac = Hash.hmacSha1('Hello World!', 'C');
        print(hmac);
        expect(hmac, '490c6611feff7834d948a3fd6f6a47b9ea0786df');
      });
    });

    group('hmac/sha224', () {
      test('Hello World / A', () {
        final hmac = Hash.hmacSha224('Hello World', 'A');
        print(hmac);
        expect(
          hmac,
          '72a48a93a6d423b49f487952fa5402caa0f3afe99038953591f841c8',
        );
      });

      test('Hello World / B', () {
        final hmac = Hash.hmacSha224('Hello World', 'B');
        print(hmac);
        expect(
          hmac,
          '9f81149228b2167f7d92af17401194f94db3a153797bdaca8a5d3c93',
        );
      });

      test('Hello World / C', () {
        final hmac = Hash.hmacSha224('Hello World', 'C');
        print(hmac);
        expect(
          hmac,
          '872f1733586a4e28343ba1c47dc4c3772801cd24346e58ec8cfc79b6',
        );
      });

      test('Hello World! / A', () {
        final hmac = Hash.hmacSha224('Hello World!', 'A');
        print(hmac);
        expect(
          hmac,
          '88cc5a001b1655c03f078d3f0fb53b38177acafbd37bd770d189432c',
        );
      });

      test('Hello World! / B', () {
        final hmac = Hash.hmacSha224('Hello World!', 'B');
        print(hmac);
        expect(
          hmac,
          'ebc0126f764b2f0a339b5400558b9b7b0c2912fc22590a1c05bbe1c3',
        );
      });

      test('Hello World! / C', () {
        final hmac = Hash.hmacSha224('Hello World!', 'C');
        print(hmac);
        expect(
          hmac,
          'd13dbf62e309ac93917af0efb87b371d6f63b204a0b46e94678b39cd',
        );
      });
    });

    group('hmac/sha256', () {
      test('Hello World / A', () {
        final hmac = Hash.hmacSha256('Hello World', 'A');
        print(hmac);
        expect(
          hmac,
          'ad87161a2d9db4813dc46e166ed2c21795660038f393f41642d9af55a4aa97b5',
        );
      });

      test('Hello World / B', () {
        final hmac = Hash.hmacSha256('Hello World', 'B');
        print(hmac);
        expect(
          hmac,
          'f005c9105ba4edc4b07a3c3f91b8b4f9e822c5e9caffbf73da05efbadbe0765e',
        );
      });

      test('Hello World / C', () {
        final hmac = Hash.hmacSha256('Hello World', 'C');
        print(hmac);
        expect(
          hmac,
          '0d8700f287783aa5967e97a902086fa5f16575bde5b8cd4b1f161dd3fa321e2f',
        );
      });

      test('Hello World! / A', () {
        final hmac = Hash.hmacSha256('Hello World!', 'A');
        print(hmac);
        expect(
          hmac,
          'b3bbcc0708e5094a8f453d3ad2a5e3a922457681badaac3956fb6b26bd86ed28',
        );
      });

      test('Hello World! / B', () {
        final hmac = Hash.hmacSha256('Hello World!', 'B');
        print(hmac);
        expect(
          hmac,
          'cd1fda91551d366fe79ec836b3eca52d9ccd51917df74728a5f980c4294dd8ac',
        );
      });

      test('Hello World! / C', () {
        final hmac = Hash.hmacSha256('Hello World!', 'C');
        print(hmac);
        expect(
          hmac,
          'af1a027dc96179642cf8ec4354ad2fe47b0befcf6dfc29ae7a74ad1c84ce0918',
        );
      });
    });

    group('hmac/sha384', () {
      test('Hello World / A', () {
        final hmac = Hash.hmacSha384('Hello World', 'A');
        print(hmac);
        expect(
          hmac,
          'e30e4f7c70a9a61622e3308bc887198186a979ac05c3fe4121a0d380d4e7b5989ae'
          '16d81560aeaefbab478c7ccfa4c82',
        );
      });

      test('Hello World / B', () {
        final hmac = Hash.hmacSha384('Hello World', 'B');
        print(hmac);
        expect(
          hmac,
          'e606c420654e9fc77aa35b93c1a635e65965a4254ea2a666762d9a8df4d9fa85588'
          'f687c4ec057290434a279cd63e32c',
        );
      });

      test('Hello World / C', () {
        final hmac = Hash.hmacSha384('Hello World', 'C');
        print(hmac);
        expect(
          hmac,
          'ab03755524abb7a3aabd89a92a003091a905ca458b31841e58fe705fb5370343cc1'
          '11d2239c72474812916eb9e3483be',
        );
      });

      test('Hello World! / A', () {
        final hmac = Hash.hmacSha384('Hello World!', 'A');
        print(hmac);
        expect(
          hmac,
          'ea26a583700caa7df6cb59b4ed36067efa97253f63e986297b97a46efa3cf3e9b0'
          'ca641b7aa7eccdb2447740a09a2797',
        );
      });

      test('Hello World! / B', () {
        final hmac = Hash.hmacSha384('Hello World!', 'B');
        print(hmac);
        expect(
          hmac,
          'd6be06f06880e5f516c2ad47fecae41c2610493b9511031ed4c1ea5cc084b3b8a0'
          'aa1fc2727fbe1a4be75f4f7fdc7b27',
        );
      });

      test('Hello World! / C', () {
        final hmac = Hash.hmacSha384('Hello World!', 'C');
        print(hmac);
        expect(
          hmac,
          'c48dbc82e9c780c129c54ae38a03193baf33229d35e66fb59f6512251e694dc93c'
          '906aa88150871babd00fb048c9eb7f',
        );
      });
    });

    group('hmac/sha512', () {
      test('Hello World / A', () {
        final hmac = Hash.hmacSha512('Hello World', 'A');
        print(hmac);
        expect(
          hmac,
          'ad3947bcf88337044bcc9b8400e2ee9480cfa80b9fe26ce9ad8f31f5f30d44a5fe52'
          '7b19cb5588acd8b064c8f87c16d7b567e2bbcd8428dc4ee95dffcb62bb4b',
        );
      });

      test('Hello World / B', () {
        final hmac = Hash.hmacSha512('Hello World', 'B');
        print(hmac);
        expect(
          hmac,
          '2599cbbf7aa8eb5e1794975afe89f00e60bab70b70cca69b8c04895ea0258cc2285'
          '1220328632c19a2f9dc0c8ca87561d26e88d4d7140d756d3bcc59ddc5324d',
        );
      });

      test('Hello World / C', () {
        final hmac = Hash.hmacSha512('Hello World', 'C');
        print(hmac);
        expect(
          hmac,
          '0636c0d408f8b5e0bd33d616d265387d503ac3d3c01ee728ae095532ca087677370c'
          '463eec4cbaec558a4a87c599265841cd4913d536252d57432e3c26bcb09c',
        );
      });

      test('Hello World! / A', () {
        final hmac = Hash.hmacSha512('Hello World!', 'A');
        print(hmac);
        expect(
          hmac,
          'da775426ce9c2552e8a17ada75731cfd43178b2f502153799e7f87b86e0016062449'
          'fd7d213adbc3075ee20ccf5ef4a5251f11370cd05c138557795d4bba7500',
        );
      });

      test('Hello World! / B', () {
        final hmac = Hash.hmacSha512('Hello World!', 'B');
        print(hmac);
        expect(
          hmac,
          '61bbc8ee5b13b709331bcabdff1d512171aa5a0b07f3901d8e59d8d627518b68d366'
          'b7e5ba957f7102551f4b850f1712129fc072048a22dff5c1c842f12f78eb',
        );
      });

      test('Hello World! / C', () {
        final hmac = Hash.hmacSha512('Hello World!', 'C');
        print(hmac);
        expect(
          hmac,
          '4ef3f2bca8f2164d27b281467a4a971f3d6cbffa57e8573439d6819fa220c7635530'
          'eef791e28ec3276cbbcefb2897c34a92e82ce59474886ad5cbbf0d1b776c',
        );
      });
    });

    group('sha512_224', () {
      test('Hello World', () {
        final hash = Hash.sha512_224('Hello World');
        print(hash);
        expect(
          hash,
          'feca41095c80a571ae782f96bcef9ab81bdf0182509a6844f32c4c17',
        );
      });

      test('Hello World!', () {
        final hash = Hash.sha512_224('Hello World!');
        print(hash);
        expect(
          hash,
          'ba0702dd8dd23280b617ef288bcc7e276060b8ebcddf28f8e4356eae',
        );
      });
    });

    group('sha512_256', () {
      test('Hello World', () {
        final hash = Hash.sha512_256('Hello World');
        print(hash);
        expect(
          hash,
          'ff20018851481c25bfc2e5d0c1e1fa57dac2a237a1a96192f99a10da47aa5442',
        );
      });

      test('Hello World!', () {
        final hash = Hash.sha512_256('Hello World!');
        print(hash);
        expect(
          hash,
          'f371319eee6b39b058ec262d4e723a26710e46761301c8b54c56fa722267581a',
        );
      });
    });
  });
}
