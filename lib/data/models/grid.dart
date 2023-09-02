import 'package:game/enums/enums.dart';

class Grid {
  final String letter;
  final GridStatus status;

  Grid(this.letter, this.status);

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
