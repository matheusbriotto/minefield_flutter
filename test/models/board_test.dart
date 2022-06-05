import 'package:flutter_test/flutter_test.dart';
import 'package:minefield/models/board.dart';

void main() {
  test('Win Game.', () {
    Board board = Board(
      rows: 2,
      columns: 2,
      quantifyBomb: 0,
    );

    board.fields[0].undermine();
    board.fields[3].undermine();

    board.fields[0].toggleMarked();
    board.fields[1].opening();
    board.fields[2].opening();
    board.fields[3].toggleMarked();

    expect(board.resolved, isTrue);
  });

  test('Added bomb to board.', () {
    Board board = Board(
      rows: 2,
      columns: 2,
      quantifyBomb: 1,
    );

    board.fields[0].undermine();

    expect(board.hasFieldMined, isTrue);
  });
}
