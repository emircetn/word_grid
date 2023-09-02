part of 'game_bloc.dart';

@immutable
class GameEvent {}

class GameStartEvent extends GameEvent {
  final GridOptions gridOptions;

  GameStartEvent(this.gridOptions);
}

class GameUpdateSelectedIndexEvent extends GameEvent {
  final int newIndex;

  GameUpdateSelectedIndexEvent(this.newIndex);
}

class GameKeyPressedEvent extends GameEvent {
  final DragPayload dragPayload;

  GameKeyPressedEvent(this.dragPayload);
}
