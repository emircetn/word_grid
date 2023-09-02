class MatrixPosition {
  final int x;
  final int y;

  MatrixPosition(this.x, this.y);

  factory MatrixPosition.fromIndex({
    required int index,
    required int yAxisSize,
  }) {
    final x = index ~/ yAxisSize;
    final y = index - (x * yAxisSize);
    return MatrixPosition(x, y);
  }

  @override
  String toString() => '(x: $x, y: $y)';
}
