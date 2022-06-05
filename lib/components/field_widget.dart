import 'package:flutter/material.dart';
import 'package:minefield/models/field.dart';

class FieldWidget extends StatelessWidget {
  final Field field;
  final void Function(Field) onOpen;
  final void Function(Field) onToggleMarked;

  FieldWidget(
      {Key? key,
      required this.field,
      required this.onOpen,
      required this.onToggleMarked})
      : super(key: key);

  Widget _getImage() {
    int quantityMine = field.numberOfMinesInTheNeighborhood;

    if(field.open && field.mined && field.blownUp) {
      return Image.asset('assets/images/bomba_0.jpeg');
    } else if (field.open && field.mined) {
      return Image.asset('assets/images/bomba_1.jpeg');
    } else if (field.open) {
      return Image.asset('assets/images/aberto_$quantityMine.jpeg');
    } else if (field.marked) {
      return Image.asset('assets/images/bandeira.jpeg');
    } else {
      return Image.asset('assets/images/fechado.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(field),
      onLongPress: () => onToggleMarked(field),
      child: _getImage(),

    );
  }
}
