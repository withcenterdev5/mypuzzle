import 'dart:developer';

import 'package:easystate/easystate.dart';
import 'package:flutter/material.dart';
import 'package:mypuzzle/puzzle.state.dart';
import 'package:mypuzzle/puzzle.piece.dart';

class Board extends StatefulWidget {
  const Board({
    super.key,
    required this.crossAxisCount,
    required this.images,
  });

  final int crossAxisCount;
  final List<String> images;

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  AppState get state => EasyState.of<AppState>(context);

  @override
  Widget build(BuildContext context) {
    log('${widget.images.length}');
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: widget.images.length,
      itemBuilder: (context, index) => EasyStateBuilder<AppState>(
        builder: (context, state) {
          return PuzzlePiece(
            numbered: state.isNumber,
            content: widget.images[index],
            space: widget.images[index] == "0",
            onTap: state.isActive
                ? () {
                    moveImage(index);
                  }
                : null,
          );
        },
      ),
    );
  }

  moveImage(index) {
    if (isMovable(index)) {
      state.setIsActive(value: true);
      state.changeImageElement(state.images.indexOf("0"), state.images[index]);
      state.changeImageElement(index, "0");
      checkWin();
      state.setMove();
    }
  }

  checkWin() {
    if (isSorted()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Congrats! You Won!'),
        ),
      );
    }
  }

  isSorted() {
    bool result = true;
    int index = 1;

    for (String item in state.images) {
      if (!item.startsWith("0") && index == 16) result = false;
      if (!item.startsWith("0") &&
          index != int.parse(item.split("/").last.substring(5, 8))) {
        result = false;
      }
      index++;
    }
    return result;
  }

  isMovable(index) {
    return index - 1 >= 0 && state.images[index - 1] == "0" || // left
        index + 1 < state.images.length &&
            state.images[index + 1] == "0" || // right
        (index - state.grid >= 0 && state.images[index - state.grid] == "0" ||
            index + state.grid < state.images.length &&
                state.images[index + state.grid] == "0");
  }
}
