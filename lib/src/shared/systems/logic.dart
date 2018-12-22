import 'dart:math';

import 'package:dartemis/dartemis.dart';
import 'package:vector_math/vector_math.dart';
import '../components.dart';

part 'logic.g.dart';

@Generate(
  EntityProcessingSystem,
  allOf: [
    Velocity,
    MovementButton,
  ],
  exclude: [
    Jumping,
  ],
)
class MovementHandlingSystem extends _$MovementHandlingSystem {
  var keyState = Map<int, bool>();

  @override
  void processEntity(Entity entity) {
    var v = velocityMapper[entity];
    var m = movementButtonMapper[entity];
    if (keyState[m.jump] == true) {
      v.velocity.y = -7.5;
      entity.addComponent(Jumping());
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

@Generate(
  EntityProcessingSystem,
  allOf: [
    Transform,
    ActionButton,
    Player,
  ],
  exclude: [
    ActionCooldown,
  ],
)
class ActionHandlingSystem extends _$ActionHandlingSystem {
  var keyState = Map<int, bool>();

  @override
  void processEntity(Entity entity) {
    var t = transformMapper[entity];
    var a = actionButtonMapper[entity];
    var p = playerMapper[entity];
    if (keyState[a.shoot] == true) {
      world.createAndAddEntity([
        Transform(t.pos.x + t.orientation * 20.0, t.pos.y, t.orientation),
        Velocity.of(t.orientation * 5.0, 0.0),
        BodyDef(Rectangle(-10, -10, 20, 20), 'fireball.png'),
        Health(1),
        Player(p.player),
        Damage()
      ]);
      entity.addComponent(ActionCooldown());
      entity.changedInWorld();
    }
  }
}

@Generate(
  EntityProcessingSystem,
  allOf: [
    ActionCooldown,
  ],
)
class ActionCooldownSystem extends _$ActionCooldownSystem {
  @override
  void processEntity(Entity entity) {
    var ac = actionCooldownMapper[entity];
    ac.duration -= world.delta;
    if (ac.duration < 0.0) {
      entity.removeComponent<ActionCooldown>();
      entity.changedInWorld();
    }
  }
}

@Generate(
  EntityProcessingSystem,
  allOf: [
    Velocity,
    Transform,
  ],
)
class MovementSystem extends _$MovementSystem {
  @override
  void processEntity(Entity entity) {
    var t = transformMapper[entity];
    var v = velocityMapper[entity];
    t.pos += v.velocity;
    if (t.pos.y > 450.0) {
      t.pos.y = 450.0;
      entity.removeComponent<Jumping>();
      entity.changedInWorld();
    }
  }
}

@Generate(
  EntityProcessingSystem,
  allOf: [
    Velocity,
    Jumping,
  ],
)
class GravitySystem extends _$GravitySystem {
  final gravity = Vector2(0.0, 0.15);

  @override
  void processEntity(Entity entity) {
    var v = velocityMapper[entity];
    v.velocity += gravity;
  }
}

@Generate(
  EntitySystem,
  allOf: [
    Transform,
    BodyDef,
    Player,
  ],
  systems: [
    CollisionHandlingSystem,
  ],
)
class CollisionDetectionSystem extends _$CollisionDetectionSystem {
  @override
  void processEntities(Iterable<Entity> entitiesInBag) {
    var entities = List<Entity>();
    entitiesInBag.forEach((entity) => entities.add(entity));
    for (int i = 0; i < entities.length - 1; i++) {
      for (int j = i + 1; j < entities.length; j++) {
        var e1 = entities[i];
        var e2 = entities[j];
        var p1 = playerMapper[e1];
        var p2 = playerMapper[e2];
        if (p1.player == p2.player) continue;

        var r1 = bodyDefMapper[e1].body;
        var r2 = bodyDefMapper[e2].body;
        var t1 = transformMapper[e1];
        var t2 = transformMapper[e2];
        var diff = t2.pos - t1.pos;
        r1 = Rectangle(r1.left + diff.x, r1.top + diff.y, r1.width, r1.height);
        if (r1.intersects(r2)) {
          collisionHandlingSystem.collisions.add(Collision(e1, e2));
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

@Generate(
  VoidEntitySystem,
  mapper: [
    Health,
    Damage,
  ],
)
class CollisionHandlingSystem extends _$CollisionHandlingSystem {
  var collisions = List<Collision>();

  @override
  void processSystem() {
    collisions.forEach((Collision collision) {
      var h1 = healthMapper[collision.entity1];
      var h2 = healthMapper[collision.entity2];
      var d1 = damageMapper.getSafe(collision.entity1);
      var d2 = damageMapper.getSafe(collision.entity2);
      if (d1 != null) {
        h2.health -= d1.damage;
        collision.entity1.deleteFromWorld();
        if (h2.health == 0) {
          collision.entity2
            ..removeComponent<BodyDef>()
            ..removeComponent<Transform>()
            ..changedInWorld();
        }
      }
      if (d2 != null) {
        h1.health -= d2.damage;
        collision.entity2.deleteFromWorld();
        if (h1.health == 0) {
          collision.entity1
            ..removeComponent<BodyDef>()
            ..removeComponent<Transform>()
            ..changedInWorld();
        }
      }
    });
  }

  @override
  void end() {
    collisions.clear();
  }

  bool checkProcessing() => collisions.isNotEmpty;
}
