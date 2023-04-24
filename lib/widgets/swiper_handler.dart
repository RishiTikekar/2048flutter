import 'package:borardgame/provider/tile_state_pvd.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwipeHandler extends StatelessWidget {
  final Widget child;
  const SwipeHandler({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final tilePvd = context.watch<TileStatePvd>();
    return GestureDetector(
      child: child,
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx < -300) {
          tilePvd.swipeHorizontal(isLeftSwipe: true);
        } else if (details.velocity.pixelsPerSecond.dx > 300) {
          tilePvd.swipeHorizontal(isLeftSwipe: false);
        }
      },
      onVerticalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dy < -200) {
          tilePvd.swipeVertical(isUpSwipe: true);
        } else if (details.velocity.pixelsPerSecond.dy > 200) {
          tilePvd.swipeVertical(isUpSwipe: false);
        }
      },
    );
  }
}
