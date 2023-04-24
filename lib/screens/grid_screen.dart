import 'dart:math';
import 'dart:developer' as dev;
import 'dart:ui';

import 'package:borardgame/constants.dart';
import 'package:borardgame/model/tile.dart';
import 'package:borardgame/styles/colors.dart';
import 'package:flutter/material.dart';

double borderRadius = 8;
double tilePadding = 2;

class GridScreen extends StatelessWidget {
  const GridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double boardSize = MediaQuery.of(context).size.width - 16;
    double singleTileSize = boardSize / Constants.gridSize;

    return Scaffold(
      body: Center(
        child: Container(
          width: boardSize,
          height: boardSize,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.black,
          ),
          child: _GridSection(tileSize: singleTileSize - 2 * tilePadding),
        ),
      ),
    );
  }
}

class _GridSection extends StatefulWidget {
  final double tileSize;
  _GridSection({
    super.key,
    required this.tileSize,
  });

  @override
  State<_GridSection> createState() => _GridSectionState();
}

class _GridSectionState extends State<_GridSection> {
  List<Widget> tilesWidgets = [];

  List<List<Tile>> tiles = List.generate(
    Constants.gridSize,
    (r) => List.generate(
      Constants.gridSize,
      (c) => Tile(x: c.toDouble(), y: r.toDouble(), val: 0),
    ),
  );

  late List<List<Tile>> columnTiles;
  @override
  void initState() {
    columnTiles = List.generate(
      Constants.gridSize,
      (r) => List.generate(
        Constants.gridSize,
        (c) => tiles[c][r],
      ),
    );
    seedNumber();
    seedNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tilesWidgets.clear();
    for (int row = 0; row < Constants.gridSize; row++) {
      for (int col = 0; col < Constants.gridSize; col++) {
        tilesWidgets.add(
          tiles[row][col].val == 0
              ? const SizedBox()
              : _TileWidget(
                  tileSize: widget.tileSize,
                  val: tiles[row][col].val,
                  x: tiles[row][col].x * (widget.tileSize + 2 * tilePadding) +
                      2,
                  y: tiles[row][col].y * (widget.tileSize + 2 * tilePadding) +
                      2,
                ),
        );
      }
    }

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx < -300) {
          if (mergeHorizontal(tiles, true)) {
            seedNumber();
            setState(() {});
          }
        } else if (details.velocity.pixelsPerSecond.dx > 300) {
          if (mergeHorizontal(tiles, false)) {
            seedNumber();
            setState(() {});
          }
        }
      },
      onVerticalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dy < -200) {
          if (mergeVertical(true)) {
            seedNumber();
            setState(() {});
          }
        } else if (details.velocity.pixelsPerSecond.dy > 200) {
          if (mergeVertical(false)) {
            seedNumber();
            setState(() {});
          }
        }
      },
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          _GridBackground(tileSize: widget.tileSize),
          ...tilesWidgets,
        ],
      ),
    );
  }

  bool mergeVertical(bool isUpSwipe) {
    return mergeHorizontal(columnTiles, isUpSwipe);
  }

  bool mergeHorizontal(List<List<Tile>> tiles, bool isLeftSwipe) {
    bool hasDoneMoves = false;
    for (List<Tile> tile in tiles) {
      List<bool> hasMerged = List.filled(tile.length, false);
      if (!isLeftSwipe) tile = tile.reversed.toList();
      for (var j = 0; j < tile.length - 1; j++) {
        for (var i = 0; i < tile.length - 1; i++) {
          if (tile[i].val == tile[i + 1].val && !hasMerged[i]) {
            tile[i].val *= 2;
            hasMerged[i] = true;
            tile[i + 1].val = 0;
            hasDoneMoves = true;
          } else if (tile[i].val == 0) {
            tile[i].val = tile[i + 1].val;
            tile[i + 1].val = 0;
            hasDoneMoves = true;
          }
        }
      }
    }
    return hasDoneMoves;
  }

  void seedNumber() {
    List<String> emptyBlocks = [];
    for (var r = 0; r < tiles.length; r++) {
      for (var c = 0; c < tiles.length; c++) {
        if (tiles[r][c].val == 0) {
          emptyBlocks.add("$r,$c");
        }
      }
    }
    dev.log(emptyBlocks.toString());

    Random randomForBlock = Random(DateTime.now().millisecondsSinceEpoch);
    int chosenBlockNo = randomForBlock.nextInt(emptyBlocks.length);

    int chosenVal = 2 + Random().nextInt(2) * 2;
    int emptyBlockX = int.parse(emptyBlocks[chosenBlockNo].split(",").first);
    int emptyBlockY = int.parse(emptyBlocks[chosenBlockNo].split(",").last);
    tiles[emptyBlockX][emptyBlockY].val = chosenVal;
  }
}

class _TileWidget extends StatelessWidget {
  final double x;

  final double y;
  final int val;
  final double tileSize;
  const _TileWidget({
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

class _GridBackground extends StatelessWidget {
  final double tileSize;
  const _GridBackground({
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
