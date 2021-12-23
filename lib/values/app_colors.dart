import 'package:flutter/material.dart';

class AppColors {
  static final Color primaryBackgroundColor = HexColor.fromHex("#181a1f");
  static final Color blueArithmeticOperatorColor = HexColor.fromHex("181A1F");
  static final Color primaryForegroundColor = HexColor.fromHex("262A34");
  static const Color white = Colors.white;
  static const Color red = Colors.red;
  static const Color green = Colors.green;
  static const Color blue = Colors.blueAccent;
}
extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}