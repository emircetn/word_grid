import 'package:game/enums/enums.dart';

class Grid {
  Grid(this.letter, this.status);
  final String letter;
  final GridStatus status;

  Grid copyWith({
    String? letter,
    GridStatus? status,
  }) {
    return Grid(
      letter ?? this.letter,
      status ?? this.status,
    );
  }
}
