part of 'game_bloc.dart';

@immutable
class GameState {}

class GameLoadingState extends GameState {}

class GamePlayState extends GameState {
  final Matrix<Grid> gridMatrix;
  final int selectedIndex;
  final bool isGameOver;

  GamePlayState({
    required this.gridMatrix,
    required this.selectedIndex,
    this.isGameOver = false,
  });
}
