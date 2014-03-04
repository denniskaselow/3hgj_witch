part of client;

class InputEventListeningSystem extends VoidEntitySystem {
  MovementHandlingSystem mhs;
  ActionHandlingSysteme ahs;
  InputEventListeningSystem();

  @override
  void initialize() {
    window.onKeyDown.listen((event) => updateKeyState(event, true));
    window.onKeyUp.listen((event) => updateKeyState(event, false));
  }

  void updateKeyState(KeyboardEvent event, bool state) {
    ahs.keyState[event.keyCode] = state;
    mhs.keyState[event.keyCode] = state;
  }

  @override
  void processSystem() {
  }

  @override
  bool checkProcessing() => false;
}
