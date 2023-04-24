import 'dart:math';
import 'dart:developer' as dev;
import 'dart:ui';

import 'package:borardgame/constants.dart';
import 'package:borardgame/provider/tile_state_pvd.dart';
import 'package:borardgame/widgets/grid_background.dart';
import 'package:borardgame/widgets/swiper_handler.dart';
import 'package:borardgame/widgets/tile_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

double borderRadius = 8;
double tilePadding = 2;

class GridScreen extends StatelessWidget {
  const GridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TileStatePvd()),
      ],
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double boardSize = MediaQuery.of(context).size.width - 16;
    double singleTileSize = boardSize / Constants.gridSize;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          _GameControlsSection(),
          Container(
            width: boardSize,
            height: boardSize,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: Colors.black,
            ),
            child: _GridSection(tileSize: singleTileSize - 2 * tilePadding),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _GridSection extends StatelessWidget {
  final double tileSize;
  _GridSection({
    super.key,
    required this.tileSize,
  });
  List<Widget> tilesWidgets = [];

  @override
  Widget build(BuildContext context) {
    final tilePvd = context.watch<TileStatePvd>();
    tilesWidgets.clear();
    for (int row = 0; row < Constants.gridSize; row++) {
      for (int col = 0; col < Constants.gridSize; col++) {
        tilesWidgets.add(
          tilePvd.tiles[row][col].val == 0
              ? const SizedBox()
              : TileWidget(
                  tileSize: tileSize,
                  val: tilePvd.tiles[row][col].val,
                  x: tilePvd.tiles[row][col].x * (tileSize + 2 * tilePadding) +
                      2,
                  y: tilePvd.tiles[row][col].y * (tileSize + 2 * tilePadding) +
                      2,
                ),
        );
      }
    }

    return SwipeHandler(
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          GridBackground(tileSize: tileSize),
          ...tilesWidgets,
        ],
      ),
    );
  }
}

class _GameControlsSection extends StatelessWidget {
  const _GameControlsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tileStatePvd = context.watch<TileStatePvd>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Text(
                "Score:  ${tileStatePvd.score}",
                style: const TextStyle(fontSize: 24),
              ),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
