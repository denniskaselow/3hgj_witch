// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$InputEventListeningSystem extends VoidEntitySystem {
  MovementHandlingSystem movementHandlingSystem;
  ActionHandlingSystem actionHandlingSystem;
  @override
  void initialize() {
    super.initialize();
    movementHandlingSystem = world.getSystem<MovementHandlingSystem>();
    actionHandlingSystem = world.getSystem<ActionHandlingSystem>();
  }
}
