import 'package:borardgame/constants.dart';
import 'package:borardgame/screens/grid_screen.dart';
import 'package:borardgame/styles/colors.dart';
import 'package:flutter/material.dart';

class GridBackground extends StatelessWidget {
  final double tileSize;
  const GridBackground({
    super.key,
    required this.tileSize,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Constants.gridSize,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
      ),
      itemCount: Constants.gridSize * Constants.gridSize,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, _) => Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.all(tilePadding),
        height: tileSize,
        width: tileSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: MyColor.lightBrown,
        ),
      ),
    );
  }
}
