import 'package:flutter/material.dart';

class MyColor {
  static const double moveInterval = .5;
  static const Color tan = const Color(0x1AFF0000);
  static const Color white = Colors.white;
  static const Color orange = Colors.orange;
  static Color lightBrown = Colors.brown.shade200;
  static const Map<int, Color> numTileColor = {
    0: tan,
    2: tan,
    4: tan,
    8: Color(0x33FF0000),
    16: Color(0x4DFF0000),
    32: Color(0x66FF0000),
    64: Color(0x80FF0000),
    128: Color(0x99FF0000),
    256: Color(0xB3FF0000),
    512: Color(0xCCFF0000),
    1024: Color(0xE6FF0000),
    2048: Color(0xFFFF0000),
  };
}
