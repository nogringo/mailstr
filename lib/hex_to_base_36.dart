String hexToBase36(String hex) {
  final bigInt = BigInt.parse(hex, radix: 16);
  return bigInt.toRadixString(36);
}

String base36ToHex(String base36) {
  final bigInt = BigInt.parse(base36, radix: 36);
  final hex = bigInt.toRadixString(16);
  // Pad with zeros to ensure 64 characters for a valid pubkey
  return hex.padLeft(64, '0');
}