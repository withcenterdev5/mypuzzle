import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  AppState();

  final List<String> whale = [
    'assets/whale/4x4/image001.png',
    'assets/whale/4x4/image002.png',
    'assets/whale/4x4/image003.png',
    'assets/whale/4x4/image004.png',
    'assets/whale/4x4/image005.png',
    'assets/whale/4x4/image006.png',
    'assets/whale/4x4/image007.png',
    'assets/whale/4x4/image008.png',
    'assets/whale/4x4/image009.png',
    'assets/whale/4x4/image010.png',
    'assets/whale/4x4/image011.png',
    'assets/whale/4x4/image012.png',
    'assets/whale/4x4/image013.png',
    'assets/whale/4x4/image014.png',
    'assets/whale/4x4/image015.png',
    "0",
  ];

  final List<String> bird = [
    'assets/bird/3x3/image001.jpg',
    'assets/bird/3x3/image002.jpg',
    'assets/bird/3x3/image003.jpg',
    'assets/bird/3x3/image004.jpg',
    'assets/bird/3x3/image005.jpg',
    'assets/bird/3x3/image006.jpg',
    'assets/bird/3x3/image007.jpg',
    'assets/bird/3x3/image008.jpg',
    "0",
  ];

  bool _isActive = false;
  List<String> _images = [];
  int _time = 0;
  int _move = 0;
  int _grid = 4;
  bool gridChanged = false;
  bool _isNumbered = false;

  bool get isNumber => _isNumbered;

  List<String> get numberedArray {
    final newList = List.generate(
      _grid * _grid,
      (index) => "${index + 1}",
    );
    newList.removeLast();
    newList.add("0");
    return newList;
  }

  List<String> get images {
    if (gridChanged) {
      _images.clear();
      _images.addAll(_grid == 3 ? bird : whale);
      gridChanged = false;
    }
    if (_images.isEmpty) _images.addAll(whale);
    return _images;
  }

  bool get isActive => _isActive;
  int get time => _time;
  int get move => _move;
  int get grid => _grid;

  changeType(bool val) {
    _isNumbered = val;
    notifyListeners();
  }

  setGrid(int val) {
    gridChanged = true;
    _grid = val;
    notifyListeners();
  }

  setImage(List<String> newImages) {
    _images = newImages;
    notifyListeners();
  }

  changeImageElement(int index, val) {
    _images[index] = val;
    notifyListeners();
  }

  shuffle() {
    images.shuffle();
    numberedArray.shuffle();
    notifyListeners();
  }

  setMove({int? value}) {
    if (value != null) {
      _move = value;
    } else {
      _move += 1;
    }
    notifyListeners();
  }

  setIsActive({required bool value}) {
    _isActive = value;
    notifyListeners();
  }

  setTime([int? seconds]) {
    if (seconds != null) {
      _time = seconds;
    } else {
      _time += 1;
    }
    notifyListeners();
  }
}
