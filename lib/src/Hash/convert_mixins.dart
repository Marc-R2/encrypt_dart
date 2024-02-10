part of '../hash.dart';

mixin ConvertDataString {
  Uint8List convertBytes(String data) => Hash.toBytes(data);
}

mixin ConvertDataBytes {
  Uint8List convertBytes(Uint8List data) => data;
}

mixin ConvertKeyString {
  Uint8List convertKey(String key) => Hash.toBytes(key);
}

mixin ConvertKeyBytes {
  Uint8List convertKey(Uint8List key) => key;
}
