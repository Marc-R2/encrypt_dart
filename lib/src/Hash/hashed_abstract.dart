part of '../hash.dart';

abstract class Hashed<T> {
  const Hashed(this.hashAlgo, this.data);

  final crypto.Hash hashAlgo;

  final T data;

  Uint8List convertBytes(T data);

  Uint8List get dataBytes => convertBytes(data);

  crypto.Digest get hashDig => hashAlgo.convert(dataBytes);

  Uint8List get hashBytes => Uint8List.fromList(hashDig.bytes);

  String get hashString => hashDig.toString();

  String substring(int start, [int? end]) => hashString.substring(start, end);
}

abstract class HashedHmac<T, K> extends Hashed<T> {
  const HashedHmac(super.hashAlgo, super.data, this.key);

  final K key;

  Uint8List convertKey(K key);

  Uint8List get keyBytes => convertKey(key);

  @override
  crypto.Digest get hashDig =>
      crypto.Hmac(hashAlgo, keyBytes).convert(dataBytes);
}
