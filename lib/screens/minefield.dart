import 'package:flutter/material.dart';
import 'package:minefield/components/board_widget.dart';
import 'package:minefield/components/result_widget.dart';
import 'package:minefield/models/board.dart';
import 'package:minefield/models/explosion_exception.dart';
import 'package:minefield/models/field.dart';

class MineField extends StatefulWidget {
  const MineField({Key? key}) : super(key: key);

  @override
  State<MineField> createState() => _MineFieldState();
}

class _MineFieldState extends State<MineField> {
  dynamic _wins;

  Board _board = Board(
    rows: 0,
    columns: 0,
    quantifyBomb: 0,
  );

  void _restart() {
    setState(() {
      _wins = null;
      _board.restart();
    });
  }

  void _open(Field field) {
    if (_wins != null) {
      return;
    }

    setState(() {
      try {
        field.opening();
        if (_board.resolved) {
          _wins = true;
        }
      } on ExplosionException {
        _wins = false;
        _board.relateBombs();
      }
    });
  }

  void _toggleMarked(Field field) {
    if (_wins != null) {
      return;
    }

    setState(() {
      field.toggleMarked();
      if (_board.resolved) {
        _wins = true;
      }
    });
  }

  Board _getBoard(double width, double height) {

    if (_board.rows == 0) {
      int quantifyColumns = 15;
      double sizeField = width / quantifyColumns;
      int quantifyRows = (height / sizeField).floor();

      _board = Board(
        rows: quantifyRows,
        columns: quantifyColumns,
        quantifyBomb: 10,
      );
    }

    return _board;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: ResultWidget(
          onRestart: _restart,
          wins: _wins,
        ),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return BoardWidget(
                board: _getBoard(constraints.maxWidth, constraints.maxHeight),
                onOpenBoard: _open,
                onToggleMarkedBoard: _toggleMarked,
              );
            },
          ),
        ),
      ),
    );
  }
}
