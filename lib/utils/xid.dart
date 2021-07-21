import "dart:typed_data";

import 'package:bson/bson.dart';

/// XID is using Mongo Object ID algorithm to generate globally unique ids.
///
/// Refer to:
///  - https://github.com/rs/xid/blob/master/id.go
///  - https://github.com/vadimtsushko/bson/blob/master/lib/src/types/objectid.dart
///
/// TODO: Add Machine ID (https://github.com/TheDOme6/device_id)
class XID {
  XID({ObjectId? oid}) : _oid = oid ?? ObjectId();

  static const encodedSize = 20;

  ObjectId _oid;

  factory XID.fromString(String xid) {
    if (xid.length != encodedSize) throw ArgumentError.value(xid);
    final bytes = Base32.decode(xid);
    for (var b in bytes) {
      if (b == 0xFF) throw ArgumentError.value(xid);
    }
    final oid = ObjectId.fromBsonBinary(BsonBinary.from(bytes));
    return XID(oid: oid);
  }

  factory XID.fromJson(String json) => XID.fromString(json);

  @override
  String toString() => Base32.encode(_oid.id.byteList);

  String toJson() => toString();

  @override
  int get hashCode => _oid.id.hexString.hashCode;

  @override
  bool operator ==(other) => other is XID && toString() == other.toString();
}

/// Refer to: https://github.com/Daegalus/dart-base32/blob/master/lib/base32.dart
/// But use different characters which from https://github.com/rs/xid/blob/master/id.go
class Base32 {
  static const _base32Chars = '0123456789abcdefghijklmnopqrstuv';

  static List<int> _buildBase32Lookup() {
    final lookup = List<int>.filled(256, 0xFF);
    for (var i = 0; i < _base32Chars.length; ++i) {
      lookup[_base32Chars.codeUnitAt(i) - '0'.codeUnitAt(0)] = i;
    }
    return lookup;
  }

  static final _base32Lookup = _buildBase32Lookup();

  static String encode(List<int> bytesList) {
    var bytes = Uint8List(bytesList.length);
    bytes.setRange(0, bytes.length, bytesList, 0);
    int i = 0, index = 0, digit = 0;
    int currByte, nextByte;
    String base32 = '';

    while (i < bytes.length) {
      currByte = bytes[i];

      if (index > 3) {
        if ((i + 1) < bytes.length) {
          nextByte = bytes[i + 1];
        } else {
          nextByte = 0;
        }

        digit = currByte & (0xFF >> index);
        index = (index + 5) % 8;
        digit <<= index;
        digit |= nextByte >> (8 - index);
        i++;
      } else {
        digit = (currByte >> (8 - (index + 5)) & 0x1F);
        index = (index + 5) % 8;
        if (index == 0) {
          i++;
        }
      }
      base32 = base32 + _base32Chars[digit];
    }
    return base32;
  }

  static Uint8List decode(String base32) {
    int index = 0, lookup, offset = 0, digit;
    Uint8List bytes = Uint8List(base32.length * 5 ~/ 8);
    for (int i = 0; i < bytes.length; i++) {
      bytes[i] = 0;
    }

    for (int i = 0; i < base32.length; i++) {
      lookup = base32.codeUnitAt(i) - '0'.codeUnitAt(0);
      if (lookup < 0 || lookup >= _base32Lookup.length) {
        continue;
      }

      digit = _base32Lookup[lookup];
      if (digit == 0xFF) {
        continue;
      }

      if (index <= 3) {
        index = (index + 5) % 8;
        if (index == 0) {
          bytes[offset] |= digit;
          offset++;
          if (offset >= bytes.length) {
            break;
          }
        } else {
          bytes[offset] |= digit << (8 - index);
        }
      } else {
        index = (index + 5) % 8;
        bytes[offset] |= (digit >> index);
        offset++;

        if (offset >= bytes.length) {
          break;
        }

        bytes[offset] |= digit << (8 - index);
      }
    }
    return bytes;
  }
}
