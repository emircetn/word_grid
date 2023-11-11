import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/constants/grid_constants.dart';
import 'package:game/data/models/drag_payload.dart';
import 'package:game/data/models/grid.dart';
import 'package:game/data/models/grid_options.dart';
import 'package:game/data/models/matrix/matrix.dart';
import 'package:game/data/models/matrix/matrix_position.dart';
import 'package:game/data/models/matrix/matrix_size.dart';
import 'package:game/data/repositories/matrix_repository.dart';
import 'package:game/enums/enums.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameLoadingState()) {
    on<GameStartEvent>(_onStartGame);
    on<GameUpdateSelectedIndexEvent>(_onUpdateSelectedIndex);
    on<GameKeyPressedEvent>(_onKeyPressedEvent);
  }
  List<int> _inactiveIndexes = [];

  late Matrix<Grid> _gridMatrix;
  late int _selectedIndex;
  late GridOptions _gridOptions;

  final matrixRepository = MatrixRepository.instance;
  final _random = Random();

  Future<void> _onStartGame(
    GameStartEvent event,
    Emitter<GameState> emit,
  ) async {
    GameLoadingState();
    final gameStartState = _initGridMatrices(gridOptions: event.gridOptions);
    emit(gameStartState);
  }

  void _onUpdateSelectedIndex(
    GameUpdateSelectedIndexEvent event,
    Emitter<GameState> emit,
  ) {
    _selectedIndex = event.newIndex;
    emit(
      GamePlayState(
        gridMatrix: _gridMatrix,
        selectedIndex: _selectedIndex,
      ),
    );
  }

  void _onKeyPressedEvent(
    GameKeyPressedEvent event,
    Emitter<GameState> emit,
  ) {
    final dragPayload = event.dragPayload;

    final matrixPosition = MatrixPosition.fromIndex(
      index: _selectedIndex,
      yAxisSize: _gridOptions.yAxisSize,
    );

    final selectedGrid = _gridMatrix.getValueWithPosition(matrixPosition);
    _gridMatrix.setValueWithPosition(
      matrixPosition,
      selectedGrid.copyWith(letter: dragPayload.letter),
    );

    _gridMatrix = matrixRepository.updateGridStatusList(
      size: MatrixSize(_gridOptions.xAxisSize, _gridOptions.yAxisSize),
      gridMatrix: _gridMatrix,
    );

    final isGameOver = _gridMatrix.getAllValues().every(
          (grid) =>
              grid.status == GridStatus.valid ||
              grid.status == GridStatus.inactive,
        );

    emit(
      GamePlayState(
        gridMatrix: _gridMatrix,
        selectedIndex: _selectedIndex,
        isGameOver: isGameOver,
      ),
    );
  }

  GamePlayState _initGridMatrices({
    required GridOptions gridOptions,
  }) {
    _gridOptions = gridOptions;

    _inactiveIndexes = _generateUniqueRandomIndexes(
      count: gridOptions.inactiveItemCount > gridOptions.gridLength - 1
          ? gridOptions.gridLength - 1
          : gridOptions.inactiveItemCount,
      max: gridOptions.gridLength,
    ).toList();

    _gridMatrix = Matrix(
      size: MatrixSize(gridOptions.xAxisSize, gridOptions.yAxisSize),
      generator: (index) {
        final letter = _inactiveIndexes.contains(index)
            ? GridConstants.inactiveCharacter
            : GridConstants.emptyCharacter;

        final status = _inactiveIndexes.contains(index)
            ? GridStatus.inactive
            : GridStatus.empty;

        return Grid(letter, status);
      },
    );

    _selectedIndex = List.generate(
      gridOptions.gridLength,
      (index) => index,
    ).firstWhere((index) => !_inactiveIndexes.contains(index));

    return GamePlayState(
      gridMatrix: _gridMatrix,
      selectedIndex: _selectedIndex,
    );
  }

  Set<int> _generateUniqueRandomIndexes({
    required int count,
    required int max,
  }) {
    final uniqueIndexes = <int>{};

    while (uniqueIndexes.length < count) {
      final randomInt = _random.nextInt(max);
      uniqueIndexes.add(randomInt);
    }

    return uniqueIndexes;
  }
}
