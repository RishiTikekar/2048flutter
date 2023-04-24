import 'package:borardgame/constants.dart';
import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  final double left;
  final double top;
  final String text;
  const TileWidget({
    super.key,
    required this.left,
    required this.top,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        height: Constants.tileSize,
        width: Constants.tileSize,
        color: Colors.red,
        child: Text(text),
      ),
    );
  }
}
