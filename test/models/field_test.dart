import 'package:flutter_test/flutter_test.dart';
import 'package:minefield/models/field.dart';

void main() {
  group('Field', () {
    test('Abrir campo com EXPLOSÃO', () {
      Field c = Field(row: 0, column: 0);
      c.undermine();

      expect(c.opening, throwsException);

    });

    test('Abrir campo SEM EXPLOSÃO', () {
      Field c = Field(row: 0, column: 0);
      c.opening();

      expect(c.open, isTrue);
    });

    test('Adicionar NÃO vizinho', () {
      Field c1 = Field(row: 0, column: 0);
      Field c2 = Field(row: 1, column: 3);
      c1.addNeighbords(c2);

      expect(c1.neighbords.isEmpty, isTrue);
    });

    test('Adicionar Vizinho', () {
      Field c1 = Field(row: 3, column: 3);
      Field c2 = Field(row: 3, column: 4);
      Field c3 = Field(row: 2, column: 2);
      Field c4 = Field(row: 4, column: 4);
      c1.addNeighbords(c2);
      c1.addNeighbords(c3);
      c1.addNeighbords(c4);

      expect(c1.neighbords.length, 3);

    });

    test('Minas na Vizinhança', () {
      Field c1 = Field(row: 3, column: 3);

      Field c2 = Field(row: 3, column: 4);
      c2.undermine();

      Field c3 = Field(row: 2, column: 2);

      Field c4 = Field(row: 4, column: 4);
      c4.undermine();

      c1.addNeighbords(c2);
      c1.addNeighbords(c3);
      c1.addNeighbords(c4);

      expect(c1.numberOfMinesInTheNeighborhood, 2);

    });
    
    test('Adicionar Vizinho', () {
      Field c1 = Field(row: 3, column: 3);
      Field c2 = Field(row: 3, column: 4);
      Field c3 = Field(row: 2, column: 2);
      Field c4 = Field(row: 4, column: 4);
      c1.addNeighbords(c2);
      c1.addNeighbords(c3);
      c1.addNeighbords(c4);

      expect(c1.neighbords.length, 3);

    });
  });
}
