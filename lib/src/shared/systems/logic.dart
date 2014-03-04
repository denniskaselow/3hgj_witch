part of shared;



class MovementHandlingSystem extends EntityProcessingSystem {
  ComponentMapper<Velocity> vm;
  ComponentMapper<MovementAction> mm;
  var keyState = new Map<int, bool>();
  MovementHandlingSystem() : super(Aspect.getAspectForAllOf([Velocity, MovementAction]).exclude([Jumping]));

  @override
  void processEntity(Entity entity) {
    var v = vm.get(entity);
    var m = mm.get(entity);
    if (keyState[m.jump] == true) {
      v.velocity.y = -5.0;
      entity.addComponent(new Jumping());
      entity.changedInWorld();
    }
    if (keyState[m.left] == true) {
      v.velocity.x = -2.0;
    } else if (keyState[m.right] == true) {
      v.velocity.x = 2.0;
    } else {
      v.velocity.x = 0.0;
    }
  }
}

class MovementSystem extends EntityProcessingSystem {
  ComponentMapper<Transform> tm;
  ComponentMapper<Velocity> vm;
  MovementSystem() : super(Aspect.getAspectForAllOf([Velocity, Transform]));

  @override
  void processEntity(Entity entity) {
    var t = tm.get(entity);
    var v = vm.get(entity);
    t.pos += v.velocity;
    if (t.pos.y > 500.0) {
      t.pos.y = 500.0;
      entity.removeComponent(Jumping);
      entity.changedInWorld();
    }
  }
}

class GravitySystem extends EntityProcessingSystem {
  final gravity = new Vector2(0.0, 0.15);
  ComponentMapper<Velocity> vm;
  GravitySystem() : super(Aspect.getAspectForAllOf([Velocity, Jumping]));

  @override
  void processEntity(Entity entity) {
    var v = vm.get(entity);
    v.velocity += gravity;
  }
}