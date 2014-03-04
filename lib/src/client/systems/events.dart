part of client;

class InputEventListeningSystem extends VoidEntitySystem {
  MovementHandlingSystem mhs;
  InputEventListeningSystem();

  @override
  void initialize() {
    window.onKeyDown.listen((event) => mhs.keyState[event.keyCode] = true);
    window.onKeyUp.listen((event) => mhs.keyState[event.keyCode] = false);
  }

  @override
  void processSystem() {
  }

  @override
  bool checkProcessing() => false;
}
