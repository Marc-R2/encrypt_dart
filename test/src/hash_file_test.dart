import 'dart:io';

import 'package:crypt/encrypt.dart';
import 'package:test/test.dart';

void main() {
  group(
    'HashFile',
    onPlatform: const {'browser': Skip('Dart:IO not supported on web')},
    () {
      Future<File> writeFile(String name, String content) async {
        final file = File('test/$name');
        await file.writeAsString(content);
        return file;
      }

      const file1Content = 'This is a test file';
      late FileHash file1Hash;

      const file2Content = 'This is another test file';
      late File file2;

      setUpAll(() async {
        final file1 = await writeFile('file1.txt', file1Content);
        file1Hash = FileHash.fromFile(file: file1);

        file2 = await writeFile('file2.txt', file2Content);
      });

      tearDownAll(() async {
        await file1Hash.file.delete();
        await file2.delete();
      });

      test('fromFile', () {
        final fileHash = FileHash.fromFile(file: file2);
        expect(fileHash.file, file2);
      });

      test('fromPath', () {
        final fileHash = FileHash.fromFilePath(path: file2.path);
        expect(fileHash.file.path, file2.path);
      });

      test('should correctly hash file with sha1', () async {
        expect(await file1Hash.sha1(), Hash.sha1(file1Content));
      });

      test('should correctly hash file with sha224', () async {
        expect(await file1Hash.sha224(), Hash.sha224(file1Content));
      });

      test('should correctly hash file with sha256', () async {
        expect(await file1Hash.sha256(), Hash.sha256(file1Content));
      });

      test('should correctly hash file with sha384', () async {
        expect(await file1Hash.sha384(), Hash.sha384(file1Content));
      });

      test('should correctly hash file with sha512', () async {
        expect(await file1Hash.sha512(), Hash.sha512(file1Content));
      });

      test('should correctly hash file with sha512_224', () async {
        expect(await file1Hash.sha512_224(), Hash.sha512_224(file1Content));
      });

      test('should correctly hash file with sha512_256', () async {
        expect(await file1Hash.sha512_256(), Hash.sha512_256(file1Content));
      });

      group('operator []', () {
        test('should correctly hash file with sha1', () async {
          expect(await file1Hash[FileHashType.sha1], Hash.sha1(file1Content));
        });

        test('should correctly hash file with sha224', () async {
          expect(
              await file1Hash[FileHashType.sha224], Hash.sha224(file1Content));
        });

        test('should correctly hash file with sha256', () async {
          expect(
              await file1Hash[FileHashType.sha256], Hash.sha256(file1Content));
        });

        test('should correctly hash file with sha384', () async {
          expect(
              await file1Hash[FileHashType.sha384], Hash.sha384(file1Content));
        });

        test('should correctly hash file with sha512', () async {
          expect(
              await file1Hash[FileHashType.sha512], Hash.sha512(file1Content));
        });

        test('should correctly hash file with sha512_224', () async {
          expect(
            await file1Hash[FileHashType.sha512_224],
            Hash.sha512_224(file1Content),
          );
        });

        test('should correctly hash file with sha512_256', () async {
          expect(
            await file1Hash[FileHashType.sha512_256],
            Hash.sha512_256(file1Content),
          );
        });
      });
    },
  );
}
