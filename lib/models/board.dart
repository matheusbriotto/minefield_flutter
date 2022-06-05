import 'dart:math';
import 'field.dart';

class Board {
  final int rows;
  final int columns;
  final int quantifyBomb;

  final List<Field> _fields = [];

  Board({
    required this.rows,
    required this.columns,
    required this.quantifyBomb,
  }) {
    _createFields();
    _relateNeighBors();
    _sortedMines();
  }

  void restart() {
    _fields.forEach((element) => element.restart());
    _sortedMines();
  }

  void relateBombs() {
    _fields.forEach((element) => element.revealBombs());
  }

  void _createFields() {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < columns; c++) {
        _fields.add(Field(row: r, column: c));
      }
    }
  }

  void _relateNeighBors() {
    for (var field in _fields) {
      for (var neighbor in _fields) {
        field.addNeighbords(neighbor);
      }
    }
  }

  void _sortedMines() {
    int sorted = 0;

    if (quantifyBomb > rows * columns) {
      return;
    }
    while (sorted < quantifyBomb) {
      int i = Random().nextInt(_fields.length);

      if (!_fields[i].mined) {
        sorted++;
        _fields[i].undermine();
      }
    }
  }

  List<Field> get fields {
    return _fields;
  }

  bool get hasFieldMined {
    var list = _fields.where((element) => element.mined);

    if (list.length > 0) return true;
    
    return false;
  }

  bool get resolved {
    return _fields.every((element) => element.resolved);
  }
}
