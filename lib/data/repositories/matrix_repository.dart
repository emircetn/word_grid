import 'package:game/data/models/grid.dart';
import 'package:game/data/models/matrix/matrix.dart';
import 'package:game/data/models/matrix/matrix_size.dart';
import 'package:game/data/services/matrix_service.dart';
import 'package:game/data/services/word_service.dart';

class MatrixRepository {
  static MatrixRepository? _instance;
  static MatrixRepository get instance {
    _instance ??= MatrixRepository._init();
    return _instance!;
  }

  MatrixRepository._init();

  final _matrixService = MatrixService.instance;
  final _wordService = WordService.instance;

  bool checkTheWord(String word) => _wordService.allWords.contains(word);

  Matrix<Grid> updateGridStatusList({
    required MatrixSize size,
    required Matrix<Grid> gridMatrix,
  }) {
    return _matrixService.updateGridStatusList(
      size: size,
      gridMatrix: gridMatrix,
      checkTheWordCallback: checkTheWord,
    );
  }
}
