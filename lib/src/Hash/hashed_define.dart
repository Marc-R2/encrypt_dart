part of '../hash.dart';

class HashedString extends Hashed<String> with ConvertDataString {
  const HashedString(super.hashAlgo, super.data);

  HashedHmacString hmac(String key) => HashedHmacString(hashAlgo, data, key);
}

class HashedBytes extends Hashed<Uint8List> with ConvertDataBytes {
  const HashedBytes(super.hashAlgo, super.data);

  HashedHmacBytes hmac(Uint8List key) => HashedHmacBytes(hashAlgo, data, key);
}

class HashedHmacString extends HashedHmac<String, String>
    with ConvertDataString, ConvertKeyString {
  HashedHmacString(super.hashAlgo, super.data, super.key);
}

class HashedHmacBytes extends HashedHmac<Uint8List, Uint8List>
    with ConvertDataBytes, ConvertKeyBytes {
  const HashedHmacBytes(super.hashAlgo, super.data, super.key);
}

// extends HashedHmac<String, Uint8List> with ConvertDataString, ConvertKeyBytes
// or
// extends HashedHmac<Uint8List, String> with ConvertDataBytes, ConvertKeyString
// would be possible
