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
      v.velocity.y = -7.5;
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
  ComponentMapper<Player> pm;
  var keyState = new Map<int, bool>();
  ActionHandlingSysteme() : super(Aspect.getAspectForAllOf([Transform, ActionButton, Player]).exclude([ActionCooldown]));

  @override
  void processEntity(Entity entity) {
    var t = tm.get(entity);
    var a = am.get(entity);
    var p = pm.get(entity);
    if (keyState[a.shoot] == true) {
      world.createAndAddEntity([new Transform(t.pos.x + t.orientation * 20.0, t.pos.y, t.orientation),
                                new Velocity.of(t.orientation * 5.0, 0.0),
                                new BodyDef(new Rectangle(-10, -10, 20, 20), 'fireball.png'),
                                new Health(1),
                                new Player(p.player),
                                new Damage()]);
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
    if (t.pos.y > 450.0) {
      t.pos.y = 450.0;
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

class CollisionDetectionSystem extends EntitySystem {
  ComponentMapper<Transform> tm;
  ComponentMapper<BodyDef> bm;
  ComponentMapper<Player> pm;
  CollisionHandlingSystem chs;
  CollisionDetectionSystem() : super(Aspect.getAspectForAllOf([Transform, BodyDef, Player]));


  @override
  void processEntities(ReadOnlyBag<Entity> entitiesInBag) {
    var entities = new List<Entity>();
    entitiesInBag.forEach((entity) => entities.add(entity));
    for (int i = 0; i < entities.length - 1; i++) {
      for (int j = i+1; j < entities.length; j++) {
        var e1 = entities[i];
        var e2 = entities[j];
        var p1 = pm.get(e1);
        var p2 = pm.get(e2);
        if (p1.player == p2.player) continue;

        var r1 = bm.get(e1).body;
        var r2 = bm.get(e2).body;
        var t1 = tm.get(e1);
        var t2 = tm.get(e2);
        var diff = t2.pos - t1.pos;
        r1 = new Rectangle(r1.left + diff.x, r1.top + diff.y, r1.width, r1.height);
        if (r1.intersects(r2)) {
          chs.collisions.add(new Collision(e1, e2));
        }
      }
    }
  }

  @override
  bool checkProcessing() => true;
}

class Collision {
  Entity entity1, entity2;
  Collision(this.entity1, this.entity2);
}

class CollisionHandlingSystem extends VoidEntitySystem {
  var collisions = new List<Collision>();
  ComponentMapper<Health> hm;
  ComponentMapper<Damage> dm;

  @override
  void processSystem() {
    collisions.forEach((Collision collision) {
      var h1 = hm.get(collision.entity1);
      var h2 = hm.get(collision.entity2);
      var d1 = dm.getSafe(collision.entity1);
      var d2 = dm.getSafe(collision.entity2);
      if (d1 != null) {
        h2.health -= d1.damage;
        collision.entity1.deleteFromWorld();
        if (h2.health == 0) {
          collision.entity2..removeComponent(BodyDef)
                           ..removeComponent(Transform)
                           ..changedInWorld();
        }
      }
      if (d2 != null) {
        h1.health -= d2.damage;
        collision.entity2.deleteFromWorld();
        if (h1.health == 0) {
          collision.entity1..removeComponent(BodyDef)
                           ..removeComponent(Transform)
                           ..changedInWorld();
        }
      }
    });
  }

  @override
  void end() {
    collisions.clear();
    world.processEntityChanges();
  }

  bool checkProcessing() => collisions.isNotEmpty;
}