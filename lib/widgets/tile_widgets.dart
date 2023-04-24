import 'package:borardgame/screens/grid_screen.dart';
import 'package:borardgame/styles/colors.dart';
import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  final double x;

  final double y;
  final int val;
  final double tileSize;
  const TileWidget({
    super.key,
    required this.val,
    required this.x,
    required this.y,
    required this.tileSize,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: y,
      left: x,
      child: Container(
        margin: EdgeInsets.zero,
        height: tileSize,
        width: tileSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: MyColor.numTileColor[val] ?? MyColor.orange,
        ),
        alignment: Alignment.center,
        child: Text(
          "$val",
          style: const TextStyle(
            color: MyColor.white,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
