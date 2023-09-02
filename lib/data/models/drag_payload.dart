class DragPayload {
  final int? currentIndex;
  final String letter;
  final bool willReplace;

  DragPayload({
    this.currentIndex,
    required this.letter,
    this.willReplace = false,
  });
}
