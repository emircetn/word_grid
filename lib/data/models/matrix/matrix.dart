import 'package:game/data/models/matrix/matrix_position.dart';
import 'package:game/data/models/matrix/matrix_size.dart';

class Matrix<T> {
  Matrix({
    required this.size,
    required T Function(int) generator,
  }) : _data = List.generate(
          size.xAxisSize,
          (mainIndex) => List.generate(
            size.yAxisSize,
            (crossIndex) {
              final index = mainIndex * size.yAxisSize + crossIndex;
              return generator(index);
            },
          ),
        );

  Matrix._internal(this.size, this._data);
  final List<List<T>> _data;
  final MatrixSize size;

  T getValue(int x, int y) {
    return _data[x][y];
  }

  T getValueWithPosition(MatrixPosition position) {
    return _data[position.x][position.y];
  }

  void setValue(int x, int y, T value) {
    _data[x][y] = value;
  }

  void setValueWithPosition(MatrixPosition position, T value) {
    _data[position.x][position.y] = value;
  }

  List<T> getAllValues() {
    return _data.expand((element) => element).toList();
  }

  Matrix<T> rotate() {
    final rows = _data.length;
    final cols = _data[0].length;

    final rotatedData =
        List.generate(cols, (i) => List<T>.generate(rows, (j) => _data[j][i]));
    final matrix = Matrix<T>._internal(size, rotatedData);
    return matrix;
  }

  Matrix<T> copy() {
    final copiedData = _data.map(List<T>.from).toList();
    return Matrix<T>._internal(size, copiedData);
  }

  List<List<T>> getRows() {
    return List.from(_data);
  }

  List<T> getRowAtIndex(int rowIndex) {
    return List.from(_data[rowIndex]);
  }
}
