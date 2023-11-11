class MatrixPosition {
  MatrixPosition(this.x, this.y);

  factory MatrixPosition.fromIndex({
    required int index,
    required int yAxisSize,
  }) {
    final x = index ~/ yAxisSize;
    final y = index - (x * yAxisSize);
    return MatrixPosition(x, y);
  }
  final int x;
  final int y;

  @override
  String toString() => '(x: $x, y: $y)';
}
