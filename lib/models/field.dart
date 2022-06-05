import 'package:flutter/foundation.dart';
import 'explosion_exception.dart';

class Field {
  final int row;
  final int column;
  final List<Field> neighbords = [];

  bool _open = false;
  bool _marked = false;
  bool _mined = false;
  bool _explode = false;

  Field({
    required this.row,
    required this.column,
  });

  void addNeighbords(Field neighbor) {
    final deltaRow = (row - neighbor.row).abs();
    final deltaColumn = (column - neighbor.column).abs();

    if (deltaRow == 0 && deltaColumn == 0) {
      return;
    }

    if (deltaRow <= 1 && deltaColumn <= 1) {
      neighbords.add(neighbor);
    }
  }

  void opening() {
    if (_open) {
      return;
    }

    _open = true;

    if (_mined) {
      _explode = true;
      throw ExplosionException();
    }

    if (safeNeighborhood) {
      neighbords.forEach((element) => element.opening());
    }
  }

  void revealBombs() {
    if (_mined) {
      _open = true;
    }
  }

  void undermine() {
    _mined = true;
  }

  void toggleMarked() {
    _marked = !_marked;
  }

  void restart() {
    _open = false;
    _marked = false;
    _mined = false;
    _explode = false;
  }

  bool get mined {
    return _mined;
  }

  bool get blownUp {
    return _explode;
  }

  bool get open {
    return _open;
  }

  bool get marked {
    return _marked;
  }

  bool get resolved {
    bool minedAndMarked = marked && mined;
    bool safeAndOpen = !mined && open;


    return minedAndMarked || safeAndOpen;
  }

  bool get safeNeighborhood {
    return neighbords.every((element) => !element.mined);
  }

  int get numberOfMinesInTheNeighborhood {
    return neighbords.where((element) => element.mined).length;
  }
}
