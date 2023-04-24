
import 'dart:math';
import 'dart:developer' as dev;
import 'package:borardgame/constants.dart';
import 'package:borardgame/model/tile.dart';

import 'package:flutter/material.dart';

class TileStatePvd with ChangeNotifier, ScoreMixin {
  List<List<Tile>> tiles = List.generate(
    Constants.gridSize,
    (r) => List.generate(
      Constants.gridSize,
      (c) => Tile(x: c.toDouble(), y: r.toDouble(), val: 0),
    ),
  );

  late List<List<Tile>> columnTiles;

  TileStatePvd() {
    init();
  }

  init() {
    columnTiles = List.generate(
      Constants.gridSize,
      (r) => List.generate(
        Constants.gridSize,
        (c) => tiles[c][r],
      ),
    );

    seedNumber();
    seedNumber();
  }

  void swipeHorizontal({required bool isLeftSwipe}) {
    if (mergeHorizontal(tiles, isLeftSwipe)) {
      seedNumber();
      notifyListeners();
    }
  }

  void swipeVertical({required bool isUpSwipe}) {
    if (mergeVertical(isUpSwipe)) {
      seedNumber();
      notifyListeners();
    }
  }

  bool mergeHorizontal(List<List<Tile>> tiles, bool isLeftSwipe) {
    bool hasDoneMoves = false;
    for (List<Tile> tile in tiles) {
      List<bool> hasMerged = List.filled(tile.length, false);
      if (!isLeftSwipe) tile = tile.reversed.toList();
      for (var j = 0; j < tile.length - 1; j++) {
        for (var i = 0; i < tile.length - 1; i++) {
          if (tile[i].val == 0) {
            tile[i].val = tile[i + 1].val;

            tile[i + 1].val = 0;
            hasDoneMoves = true;
          } else if (tile[i].val == tile[i + 1].val && !hasMerged[i]) {
            addScore(tile[i].val);
            tile[i].val *= 2;
            hasMerged[i] = true;
            tile[i + 1].val = 0;
            hasDoneMoves = true;
          }
        }
      }
    }
    dev.log(hasDoneMoves.toString());
    return hasDoneMoves;
  }

  bool mergeVertical(bool isUpSwipe) {
    return mergeHorizontal(columnTiles, isUpSwipe);
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

mixin ScoreMixin {
  int _score = 0;

  int get score => _score;

  void addScore(int val) {
    _score += val;
  }
}
