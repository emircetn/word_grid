class GridOptions {
  GridOptions({
    required int xAxisSize,
    required int yAxisSize,
    required int inactiveItemCount,
  })  : _xAxisSize = xAxisSize,
        _yAxisSize = yAxisSize,
        _inactiveItemCount = inactiveItemCount;
  int _xAxisSize;
  int _yAxisSize;
  int _inactiveItemCount;

  int get xAxisSize => _xAxisSize;
  int get yAxisSize => _yAxisSize;
  int get inactiveItemCount => _inactiveItemCount;

  int get gridLength => _xAxisSize * _yAxisSize;

  set xAxisSize(int value) {
    if (value >= 0) {
      _xAxisSize = value;
    }
  }

  set yAxisSize(int value) {
    if (value >= 0) {
      _yAxisSize = value;
    }
  }

  set inactiveItemCount(int value) {
    if (value >= 0) {
      _inactiveItemCount = value;
    }
  }
}
