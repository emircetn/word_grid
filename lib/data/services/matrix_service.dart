import 'package:game/constants/grid_constants.dart';
import 'package:game/data/models/grid.dart';
import 'package:game/data/models/matrix/matrix.dart';
import 'package:game/data/models/matrix/matrix_size.dart';
import 'package:game/enums/enums.dart';
import 'package:game/extensions/string_extensions.dart';

typedef WordCheckCallback = bool Function(String);

class MatrixService {
  MatrixService._init();
  static MatrixService? _instance;
  static MatrixService get instance {
    _instance ??= MatrixService._init();
    return _instance!;
  }

  Matrix<Grid> updateGridStatusList({
    required MatrixSize size,
    required Matrix<Grid> gridMatrix,
    required WordCheckCallback checkTheWordCallback,
  }) {
    //vertical için kontrol et
    final xNewGridMatrix = _scanGridStatusToOneAxis(
      matrix: gridMatrix,
      checkTheWordCallback: checkTheWordCallback,
    );

    //horizontal için kontrol edileceğinden matrixleri döndür
    final rotatedGridMatrix = gridMatrix.rotate();
    final rotatedNewGridMatrix = _scanGridStatusToOneAxis(
      matrix: rotatedGridMatrix,
      checkTheWordCallback: checkTheWordCallback,
    );

    //horizontal tamamlandı. vertical ile karşılaştırlması için tekrar
    //horizontal ile aynı eksenine çevir
    final yNewGridMatrix = rotatedNewGridMatrix.rotate();

    final updatedGridMatrix = gridMatrix.copy();

    for (var xAxisIndex = 0; xAxisIndex < size.xAxisSize; xAxisIndex++) {
      for (var yAxisIndex = 0; yAxisIndex < size.yAxisSize; yAxisIndex++) {
        final verticalGrid = xNewGridMatrix.getValue(xAxisIndex, yAxisIndex);
        final horizontalGrid = yNewGridMatrix.getValue(xAxisIndex, yAxisIndex);

        final letter = verticalGrid.letter;
        final status = verticalGrid.status.compare(horizontalGrid.status);
        final grid = Grid(letter, status);

        updatedGridMatrix.setValue(xAxisIndex, yAxisIndex, grid);
      }
    }
    return updatedGridMatrix;
  }

  Matrix<Grid> _scanGridStatusToOneAxis({
    required Matrix<Grid> matrix,
    required WordCheckCallback checkTheWordCallback,
  }) {
    final newGridStatusList = matrix.copy();

    void updateGridStatusList(
      List<int> wordIndexes,
      int xIndex,
      GridStatus gridStatus,
    ) {
      for (final yIndex in wordIndexes) {
        final newGrid = newGridStatusList
            .getValue(xIndex, yIndex)
            .copyWith(status: gridStatus);

        newGridStatusList.setValue(xIndex, yIndex, newGrid);
      }
    }

    final letterMap = <int, String>{};
    for (var rowIndex = 0; rowIndex < matrix.getRows().length; rowIndex++) {
      letterMap.clear();

      final matrixRow = matrix.getRowAtIndex(rowIndex);
      for (var axisIndex = 0; axisIndex < matrixRow.length; axisIndex++) {
        final grid = matrixRow[axisIndex];

        final isLastIndex = axisIndex == matrixRow.length - 1;
        final isInactiveCharacter =
            grid.letter == GridConstants.inactiveCharacter;

        if (!isInactiveCharacter) {
          letterMap[axisIndex] = grid.letter;
          if (!isLastIndex) continue;
        }

        if (letterMap.isNotEmpty) {
          final word = letterMap.values.toList().join().toLowerCaseTr;
          final wordIndexes = letterMap.keys.toList().cast<int>();
          if (word.contains(GridConstants.emptyCharacter)) {
            updateGridStatusList(wordIndexes, rowIndex, GridStatus.empty);
          } else {
            final isWordValid = checkTheWordCallback(word);
            final newGridStatus =
                isWordValid ? GridStatus.valid : GridStatus.invalid;
            updateGridStatusList(wordIndexes, rowIndex, newGridStatus);
          }

          letterMap.clear();
        }
      }
    }
    return newGridStatusList;
  }
}
