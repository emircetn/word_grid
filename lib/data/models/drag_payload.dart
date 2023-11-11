class DragPayload {
  DragPayload({
    required this.letter,
    this.currentIndex,
    this.willReplace = false,
  });
  final int? currentIndex;
  final String letter;
  final bool willReplace;
}
