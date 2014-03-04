part of shared;



class MovementHandlingSystem extends EntityProcessingSystem {
  ComponentMapper<Velocity> vm;
  ComponentMapper<MovementButton> mm;
  var keyState = new Map<int, bool>();
  MovementHandlingSystem() : super(Aspect.getAspectForAllOf([Velocity, MovementButton]).exclude([Jumping]));

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

class ActionHandlingSysteme extends EntityProcessingSystem {
  ComponentMapper<Transform> tm;
  ComponentMapper<ActionButton> am;
  var keyState = new Map<int, bool>();
  ActionHandlingSysteme() : super(Aspect.getAspectForAllOf([Transform, ActionButton]).exclude([ActionCooldown]));

  @override
  void processEntity(Entity entity) {
    var t = tm.get(entity);
    var a = am.get(entity);
    if (keyState[a.shoot] == true) {
      world.createAndAddEntity([new Transform(t.pos.x, t.pos.y, t.orientation), new Velocity.of(t.orientation * 2.0, 0.0)]);
      entity.addComponent(new ActionCooldown());
      entity.changedInWorld();
    }
  }
}

class ActionCooldownSystem extends EntityProcessingSystem {
  ComponentMapper<ActionCooldown> acm;
  ActionCooldownSystem() : super(Aspect.getAspectForAllOf([ActionCooldown]));

  @override
  void processEntity(Entity entity) {
    var ac = acm.get(entity);
    ac.duration -= world.delta;
    if (ac.duration < 0.0) {
      entity.removeComponent(ActionCooldown);
      entity.changedInWorld();
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