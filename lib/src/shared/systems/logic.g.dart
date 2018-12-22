// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logic.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$MovementHandlingSystem extends EntityProcessingSystem {
  Mapper<Velocity> velocityMapper;
  Mapper<MovementButton> movementButtonMapper;
  _$MovementHandlingSystem()
      : super(Aspect.empty()
          ..allOf([Velocity, MovementButton])
          ..exclude([Jumping]));
  @override
  void initialize() {
    super.initialize();
    velocityMapper = Mapper<Velocity>(world);
    movementButtonMapper = Mapper<MovementButton>(world);
  }
}

abstract class _$ActionHandlingSystem extends EntityProcessingSystem {
  Mapper<Transform> transformMapper;
  Mapper<ActionButton> actionButtonMapper;
  Mapper<Player> playerMapper;
  _$ActionHandlingSystem()
      : super(Aspect.empty()
          ..allOf([Transform, ActionButton, Player])
          ..exclude([ActionCooldown]));
  @override
  void initialize() {
    super.initialize();
    transformMapper = Mapper<Transform>(world);
    actionButtonMapper = Mapper<ActionButton>(world);
    playerMapper = Mapper<Player>(world);
  }
}

abstract class _$ActionCooldownSystem extends EntityProcessingSystem {
  Mapper<ActionCooldown> actionCooldownMapper;
  _$ActionCooldownSystem() : super(Aspect.empty()..allOf([ActionCooldown]));
  @override
  void initialize() {
    super.initialize();
    actionCooldownMapper = Mapper<ActionCooldown>(world);
  }
}

abstract class _$MovementSystem extends EntityProcessingSystem {
  Mapper<Velocity> velocityMapper;
  Mapper<Transform> transformMapper;
  _$MovementSystem() : super(Aspect.empty()..allOf([Velocity, Transform]));
  @override
  void initialize() {
    super.initialize();
    velocityMapper = Mapper<Velocity>(world);
    transformMapper = Mapper<Transform>(world);
  }
}

abstract class _$GravitySystem extends EntityProcessingSystem {
  Mapper<Velocity> velocityMapper;
  Mapper<Jumping> jumpingMapper;
  _$GravitySystem() : super(Aspect.empty()..allOf([Velocity, Jumping]));
  @override
  void initialize() {
    super.initialize();
    velocityMapper = Mapper<Velocity>(world);
    jumpingMapper = Mapper<Jumping>(world);
  }
}

abstract class _$CollisionDetectionSystem extends EntitySystem {
  Mapper<Transform> transformMapper;
  Mapper<BodyDef> bodyDefMapper;
  Mapper<Player> playerMapper;
  CollisionHandlingSystem collisionHandlingSystem;
  _$CollisionDetectionSystem()
      : super(Aspect.empty()..allOf([Transform, BodyDef, Player]));
  @override
  void initialize() {
    super.initialize();
    transformMapper = Mapper<Transform>(world);
    bodyDefMapper = Mapper<BodyDef>(world);
    playerMapper = Mapper<Player>(world);
    collisionHandlingSystem = world.getSystem<CollisionHandlingSystem>();
  }
}

abstract class _$CollisionHandlingSystem extends VoidEntitySystem {
  Mapper<Health> healthMapper;
  Mapper<Damage> damageMapper;
  @override
  void initialize() {
    super.initialize();
    healthMapper = Mapper<Health>(world);
    damageMapper = Mapper<Damage>(world);
  }
}
