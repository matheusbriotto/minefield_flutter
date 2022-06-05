import 'package:flutter/material.dart';
import 'package:minefield/components/field_widget.dart';

import 'package:minefield/models/board.dart';
import 'package:minefield/models/field.dart';

class BoardWidget extends StatelessWidget {
  final Board board;
  final void Function(Field) onOpenBoard;
  final void Function(Field) onToggleMarkedBoard;

  BoardWidget(
      {Key? key,
      required this.board,
      required this.onOpenBoard,
      required this.onToggleMarkedBoard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('colunas:' + this.board.columns.toString());
    return Container(
      child: GridView.count(
        crossAxisCount: board.columns,
        children: board.fields.map((element) {
          return FieldWidget(
            field: element,
            onOpen: onOpenBoard,
            onToggleMarked: onToggleMarkedBoard,
          );
        }).toList(),
      ),
    );
  }
}
