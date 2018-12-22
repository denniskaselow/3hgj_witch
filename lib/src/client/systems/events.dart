import 'dart:html';
import 'package:dartemis/dartemis.dart';
import 'package:thgj_witch/shared.dart';

part 'events.g.dart';

@Generate(
  VoidEntitySystem,
  systems: [
    MovementHandlingSystem,
    ActionHandlingSystem,
  ],
)
class InputEventListeningSystem extends _$InputEventListeningSystem {

  @override
  void initialize() {
    super.initialize();
    window.onKeyDown.listen((event) => updateKeyState(event, true));
    window.onKeyUp.listen((event) => updateKeyState(event, false));
  }

  void updateKeyState(KeyboardEvent event, bool state) {
    actionHandlingSystem.keyState[event.keyCode] = state;
    movementHandlingSystem.keyState[event.keyCode] = state;
  }

  @override
  void processSystem() {}

  @override
  bool checkProcessing() => false;
}
