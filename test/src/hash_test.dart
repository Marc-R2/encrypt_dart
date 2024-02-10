import 'dart:typed_data';

import 'package:crypt/encrypt.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:test/test.dart';

const helloWorld = HashTest(
  data: 'Hello World',
  expectedSha1: '0a4d55a8d778e5022fab701977c5d840bbc486d0',
  expectedSha224: 'c4890faffdb0105d991a461e668e276685401b02eab1ef4372795047',
  expectedSha256:
      'a591a6d40bf420404a011733cfb7b190d62c65bf0bcda32b57b277d9ad9f146e',
  expectedSha384: '99514329186b2f6ae4a1329e7ee6c610a729636335174ac6b740f9'
      '028396fcc803d0e93863a7c3d90f86beee782f4f3f',
  expectedSha512: '2c74fd17edafd80e8447b0d46741ee243b7eb74dd2149a0ab1b9246fb3'
      '0382f27e853d8585719e0e67cbda0daa8f51671064615d645ae27acb15bfb1447f459b',
  expectedMd5: 'b10a8db164e0754105b7a99be72e3fe5',
  expectedSha512_224:
      'feca41095c80a571ae782f96bcef9ab81bdf0182509a6844f32c4c17',
  expectedSha512_256:
      'ff20018851481c25bfc2e5d0c1e1fa57dac2a237a1a96192f99a10da47aa5442',
);

const helloWorld2 = HashTest(
  data: 'Hello World!',
  expectedSha1: '2ef7bde608ce5404e97d5f042f95f89f1c232871',
  expectedSha224: '4575bb4ec129df6380cedde6d71217fe0536f8ffc4e18bca530a7a1b',
  expectedSha256:
      '7f83b1657ff1fc53b92dc18148a1d65dfc2d4b1fa3d677284addd200126d9069',
  expectedSha384: 'bfd76c0ebbd006fee583410547c1887b0292be76d582d96c242d2a79272'
      '3e3fd6fd061f9d5cfd13b8f961358e6adba4a',
  expectedSha512: '861844d6704e8573fec34d967e20bcfef3d424cf48be04e6dc08f2bd58'
      'c729743371015ead891cc3cf1c9d34b49264b510751b1ff9e537937bc46b5d6ff4ecc8',
  expectedMd5: 'ed076287532e86365e841e92bfc50d8c',
  expectedSha512_224:
      'ba0702dd8dd23280b617ef288bcc7e276060b8ebcddf28f8e4356eae',
  expectedSha512_256:
      'f371319eee6b39b058ec262d4e723a26710e46761301c8b54c56fa722267581a',
);

const bitbotCOM = HashTest(
  data: 'BitBot - COM',
  expectedSha1: '6b062511d811fd31e804c973c02ed69c202596c5',
  expectedSha224: 'ce5283bf902d6d71668ebc90e98c14caf11ddb82e191dfb5f8e73b94',
  expectedSha256:
      'dbd1bc81e6f1c6a6d73d5a6d93d827f2aa1ee432db540ad44f98f6ae4b94e613',
  expectedSha384: 'c7e4a9fc21fe9a8366d067d8268e3a7c26a65a01a5168f0ade44b9abed'
      '0e039b7428d39521534edd3b3fe5e6d6567a00',
  expectedSha512: 'fca3a254a3a04424351526351fe9e8601187d17f63723f4934dcda3f33'
      'd69023a0ae7c6d969fca112dea566654796f9ec6032b997e70c47b7d93c3ca47d7684d',
  expectedMd5: '635372c9292116c1bdcb5f06033b9a4c',
  expectedSha512_224:
      '1e61cbc776de7e784e6ef804afd3bf8816ab844c13ea97761748a736',
  expectedSha512_256:
      '321e4ee43febde72b4ee33cf5c03001ad74d9bed3f33bdd37f3fcd7c4e6100f8',
);

const bitbotCOM2 = HashTest(
  data: 'BitBot - COM!',
  expectedSha1: '9e2777466eadb0d7cf9ff380402e7e187c91a537',
  expectedSha224: '88a836343d87aaf4e2b39887226b0dc80aaf547871871c1e4c050742',
  expectedSha256:
      '7879d3b2934e1075c8ec15ce1610d5a54983bf15bb993749739f5a5ec466fb2b',
  expectedSha384: 'f8d200dc73f89cfb173209aa2b124417bf661df20f38fbd1ae2466f1dd'
      '04994df19e5890164130efebe0b9c05707bb0c',
  expectedSha512: '751753581831b151dadd8729e87a0d16dddb6cbfdabb271397a4780611'
      'fe3a97641343072479d397920a0bd9fe22d220b4fef35e2cede404cd93fb5baa201232',
  expectedMd5: '5a46aed3404eb117b34e70df86dcdef3',
  expectedSha512_224:
      '9f2e333728c96fa634eca388b4201fcedecb8e6415a6af0b9109f7b5',
  expectedSha512_256:
      'e321d7a8eccf5ef76b4b7eacc559bbe2de10ca4f4ab3fe5683153036c38442f2',
);

const hmacHelloWorldA = HashHmacTest(
  key: 'A',
  data: 'Hello World',
  expectedSha1: 'e22d9d5349192fb2ee683c13ab0ca0ec85a3f7dc',
  expectedSha224: '72a48a93a6d423b49f487952fa5402caa0f3afe99038953591f841c8',
  expectedSha256:
      'ad87161a2d9db4813dc46e166ed2c21795660038f393f41642d9af55a4aa97b5',
  expectedSha384: 'e30e4f7c70a9a61622e3308bc887198186a979ac05c3fe4121a0d380d4'
      'e7b5989ae16d81560aeaefbab478c7ccfa4c82',
  expectedSha512: 'ad3947bcf88337044bcc9b8400e2ee9480cfa80b9fe26ce9ad8f31f5f3'
      '0d44a5fe527b19cb5588acd8b064c8f87c16d7b567e2bbcd8428dc4ee95dffcb62bb4b',
  expectedMd5: 'ef1b064969477d0d78eb76beb1c50eea',
  expectedSha512_224:
      'ead3cc08a9adc01167134a405da736ef09304eaa57a6ee3fde834751',
  expectedSha512_256:
      '90abba2bc8ef824daacf063716e4336d9bda9cc6541f2b9b4dc185813e9380b9',
);

const hmacHelloWorldB = HashHmacTest(
  key: 'B',
  data: 'Hello World',
  expectedSha1: '3c908b7cc9328f58ce83743a1362a2abb9a6223c',
  expectedSha224: '9f81149228b2167f7d92af17401194f94db3a153797bdaca8a5d3c93',
  expectedSha256:
      'f005c9105ba4edc4b07a3c3f91b8b4f9e822c5e9caffbf73da05efbadbe0765e',
  expectedSha384: 'e606c420654e9fc77aa35b93c1a635e65965a4254ea2a666762d9a8df4'
      'd9fa85588f687c4ec057290434a279cd63e32c',
  expectedSha512: '2599cbbf7aa8eb5e1794975afe89f00e60bab70b70cca69b8c04895ea0'
      '258cc22851220328632c19a2f9dc0c8ca87561d26e88d4d7140d756d3bcc59ddc5324d',
  expectedMd5: '5afd182bd61f3098922e1f76a659acae',
  expectedSha512_224:
      'd43b3a8b0f1f6f8aa0d34aac67f3ad61c45e4a13ad7e38612731ad67',
  expectedSha512_256:
      '8d305bbb5023c7c340eb2f89f91c758931b76f00a8bab3fdce85d01e922472be',
);

const hmacHelloWorldC = HashHmacTest(
  key: 'C',
  data: 'Hello World',
  expectedSha1: 'e28f57696eef79c93cca75afedda87c208eeae2d',
  expectedSha224: '872f1733586a4e28343ba1c47dc4c3772801cd24346e58ec8cfc79b6',
  expectedSha256:
      '0d8700f287783aa5967e97a902086fa5f16575bde5b8cd4b1f161dd3fa321e2f',
  expectedSha384: 'ab03755524abb7a3aabd89a92a003091a905ca458b31841e58fe705fb5'
      '370343cc111d2239c72474812916eb9e3483be',
  expectedSha512: '0636c0d408f8b5e0bd33d616d265387d503ac3d3c01ee728ae095532ca'
      '087677370c463eec4cbaec558a4a87c599265841cd4913d536252d57432e3c26bcb09c',
  expectedMd5: 'aeac496fadb00c2e87dc24258d7dbbda',
  expectedSha512_224:
      '8fec501635c977cea7a2bda0ac7e4ac296d21912bfc6aa5a645f7625',
  expectedSha512_256:
      '6591325cbcaa7a64ad00059148e9ea8f25d296ce033923dba1ed75cc1380edb1',
);

const hmacHelloWorldA2 = HashHmacTest(
  key: 'A',
  data: 'Hello World!',
  expectedSha1: 'ea5f2362e78ead7e1abcff06ed46ce494d567ebb',
  expectedSha224: '88cc5a001b1655c03f078d3f0fb53b38177acafbd37bd770d189432c',
  expectedSha256:
      'b3bbcc0708e5094a8f453d3ad2a5e3a922457681badaac3956fb6b26bd86ed28',
  expectedSha384: 'ea26a583700caa7df6cb59b4ed36067efa97253f63e986297b97a46efa'
      '3cf3e9b0ca641b7aa7eccdb2447740a09a2797',
  expectedSha512: 'da775426ce9c2552e8a17ada75731cfd43178b2f502153799e7f87b86e'
      '0016062449fd7d213adbc3075ee20ccf5ef4a5251f11370cd05c138557795d4bba7500',
  expectedMd5: '2986ff177c07c82e95933b056b7a8848',
  expectedSha512_224:
      '30cc7cffc88818e1312a46664f3d6400a7eba1aaff53a3cde3e89d11',
  expectedSha512_256:
      '310f84e81c989b7bf514b9565fc938582efb3028bdbea86ffab5a289e3f95861',
);

const hmacHelloWorldB2 = HashHmacTest(
  key: 'B',
  data: 'Hello World!',
  expectedSha1: 'cea13559b4f2254e6641d4e8fefce9a1dd508d98',
  expectedSha224: 'ebc0126f764b2f0a339b5400558b9b7b0c2912fc22590a1c05bbe1c3',
  expectedSha256:
      'cd1fda91551d366fe79ec836b3eca52d9ccd51917df74728a5f980c4294dd8ac',
  expectedSha384: 'd6be06f06880e5f516c2ad47fecae41c2610493b9511031ed4c1ea5cc0'
      '84b3b8a0aa1fc2727fbe1a4be75f4f7fdc7b27',
  expectedSha512: '61bbc8ee5b13b709331bcabdff1d512171aa5a0b07f3901d8e59d8d627'
      '518b68d366b7e5ba957f7102551f4b850f1712129fc072048a22dff5c1c842f12f78eb',
  expectedMd5: 'dcf6e01cc1e2fcc6d58d9aaed927c0ae',
  expectedSha512_224:
      'd8225802bcee40c0543dff239d41912c2432836d0635c7eeec367a84',
  expectedSha512_256:
      '7cd1368c9e561bbed82ffbf365a3f6e8fc35c21c892ce8e3b2fc3c584e1fb0ec',
);

const hmacHelloWorldC2 = HashHmacTest(
  key: 'C',
  data: 'Hello World!',
  expectedSha1: '490c6611feff7834d948a3fd6f6a47b9ea0786df',
  expectedSha224: 'd13dbf62e309ac93917af0efb87b371d6f63b204a0b46e94678b39cd',
  expectedSha256:
      'af1a027dc96179642cf8ec4354ad2fe47b0befcf6dfc29ae7a74ad1c84ce0918',
  expectedSha384: 'c48dbc82e9c780c129c54ae38a03193baf33229d35e66fb59f6512251e'
      '694dc93c906aa88150871babd00fb048c9eb7f',
  expectedSha512: '4ef3f2bca8f2164d27b281467a4a971f3d6cbffa57e8573439d6819fa2'
      '20c7635530eef791e28ec3276cbbcefb2897c34a92e82ce59474886ad5cbbf0d1b776c',
  expectedMd5: 'fb0bdd3237a9cff5cef897041354fa23',
  expectedSha512_224:
      '39a1ad00ba418de1951ba4bdaf9b7a2ebcf3a3424e4864777a87db27',
  expectedSha512_256:
      '73da2befee03ee96e68472ad6c2d5a5c37713c388f37ed7c35dc29397e85c06c',
);

void main() {
  group('Hash', () {
    helloWorld.testGroup();
    helloWorld2.testGroup();
    bitbotCOM.testGroup();
    bitbotCOM2.testGroup();

    hmacHelloWorldA.testGroup();
    hmacHelloWorldB.testGroup();
    hmacHelloWorldC.testGroup();

    hmacHelloWorldA2.testGroup();
    hmacHelloWorldB2.testGroup();
    hmacHelloWorldC2.testGroup();
  });
}

class HashTest {
  const HashTest({
    required this.data,
    required this.expectedSha1,
    required this.expectedSha224,
    required this.expectedSha256,
    required this.expectedSha384,
    required this.expectedSha512,
    required this.expectedMd5,
    required this.expectedSha512_224,
    required this.expectedSha512_256,
  });

  final String data;

  final String expectedSha1;
  final String expectedSha224;
  final String expectedSha256;
  final String expectedSha384;
  final String expectedSha512;
  final String expectedMd5;
  final String expectedSha512_224;
  final String expectedSha512_256;

  void expected(
      Hashed<String> Function(String) target,
      String expected,
      crypto.Hash hash,
      ) {
    final hashed = target(data);

    print(hashed.hashString);

    expect(hashed.hashAlgo, hash);
    expect(hashed.hashBytes, hexToBytes(expected));
    expect(hashed.hashString, expected);
  }

  Uint8List hexToBytes(String hex) {
    final result = <int>[];
    for (var i = 0; i < hex.length; i += 2) {
      result.add(int.parse(hex.substring(i, i + 2), radix: 16));
    }
    return Uint8List.fromList(result);
  }

  void testGroup() {
    group('testing hashing "$data"', () {
      test('Hash.sha1', () {
        expected(Hash.sha1, expectedSha1, crypto.sha1);
      });
      test('Hash.sha224', () {
        expected(Hash.sha224, expectedSha224, crypto.sha224);
      });
      test('Hash.sha256', () {
        expected(Hash.sha256, expectedSha256, crypto.sha256);
      });
      test('Hash.sha384', () {
        expected(Hash.sha384, expectedSha384, crypto.sha384);
      });
      test('Hash.sha512', () {
        expected(Hash.sha512, expectedSha512, crypto.sha512);
      });
      test('Hash.md5', () {
        expected(Hash.md5, expectedMd5, crypto.md5);
      });
      test('Hash.sha512_224', () {
        expected(Hash.sha512_224, expectedSha512_224, crypto.sha512224);
      });
      test('Hash.sha512_256', () {
        expected(Hash.sha512_256, expectedSha512_256, crypto.sha512256);
      });
    });
  }
}

class HashHmacTest extends HashTest {
  const HashHmacTest({
    required this.key,
    required super.data,
    required super.expectedSha1,
    required super.expectedSha224,
    required super.expectedSha256,
    required super.expectedSha384,
    required super.expectedSha512,
    required super.expectedMd5,
    required super.expectedSha512_224,
    required super.expectedSha512_256,
  });

  final String key;

  void expectedHmac(
      HashedHmacString Function(String, String) target,
      String expected,
      crypto.Hash hash,
      ) {
    final hashed = target(data, key);

    print(hashed.hashString);

    expect(hashed.hashAlgo, hash);
    expect(hashed.hashBytes, hexToBytes(expected));
    expect(hashed.hashString, expected);
  }

  @override
  void testGroup() {
    group('testing hashing "$data" with key "$key"', () {
      test('Hash.hmacSha1', () {
        expectedHmac(Hash.hmacSha1, expectedSha1, crypto.sha1);
      });
      test('Hash.hmacSha224', () {
        expectedHmac(Hash.hmacSha224, expectedSha224, crypto.sha224);
      });
      test('Hash.hmacSha256', () {
        expectedHmac(Hash.hmacSha256, expectedSha256, crypto.sha256);
      });
      test('Hash.hmacSha384', () {
        expectedHmac(Hash.hmacSha384, expectedSha384, crypto.sha384);
      });
      test('Hash.hmacSha512', () {
        expectedHmac(Hash.hmacSha512, expectedSha512, crypto.sha512);
      });
      test('Hash.hmacMd5', () {
        expectedHmac(Hash.hmacMd5, expectedMd5, crypto.md5);
      });
      test('Hash.hmacSha512_224', () {
        expectedHmac(Hash.hmacSha512_224, expectedSha512_224, crypto.sha512224);
      });
      test('Hash.hmacSha512_256', () {
        expectedHmac(Hash.hmacSha512_256, expectedSha512_256, crypto.sha512256);
      });
    });
  }
}
