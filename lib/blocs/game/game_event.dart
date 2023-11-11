part of 'game_bloc.dart';

@immutable
class GameEvent {}

class GameStartEvent extends GameEvent {
  GameStartEvent(this.gridOptions);
  final GridOptions gridOptions;
}

class GameUpdateSelectedIndexEvent extends GameEvent {
  GameUpdateSelectedIndexEvent(this.newIndex);
  final int newIndex;
}

class GameKeyPressedEvent extends GameEvent {
  GameKeyPressedEvent(this.dragPayload);
  final DragPayload dragPayload;
}
