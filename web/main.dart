import 'dart:html';

import 'package:gamedev_helpers/gamedev_helpers.dart' hide Velocity;
import 'package:thgj_witch/shared.dart';
import 'package:thgj_witch/client.dart';

void main() {
  Game().start();
}

class Game extends GameBase {
  Game() : super('thgj_witch', 'canvas', bodyDefsName: null);

  void createEntities() {
    addEntity([
      Transform(100, 450, 1),
      BodyDef(Rectangle(-20, -100, 40, 200), 'witch.png'),
      Velocity(),
      MovementButton(KeyCode.W, KeyCode.A, KeyCode.S, KeyCode.D),
      ActionButton(KeyCode.J),
      Health(10),
      HealthBar(200, 100),
      Player(1)
    ]);
    addEntity([
      Transform(700, 450, -1),
      BodyDef(Rectangle(-50, -100, 100, 200), 'fairy.png'),
      Velocity(),
      MovementButton(KeyCode.UP, KeyCode.LEFT, KeyCode.DOWN, KeyCode.RIGHT),
      ActionButton(KeyCode.NUM_ONE),
      Health(10),
      HealthBar(600, 100),
      Player(2)
    ]);
  }

  @override
  Map<int, List<EntitySystem>> getSystems() {
    return {
      GameBase.rendering: [
        InputEventListeningSystem(),
        MovementHandlingSystem(),
        GravitySystem(),
        MovementSystem(),
        ActionHandlingSystem(),
        ActionCooldownSystem(),
        CollisionDetectionSystem(),
        CollisionHandlingSystem(),
        CanvasCleaningSystem(canvas),
        BackgroundRenderingSystem(ctx, spriteSheet),
        EntityRenderingSysteme(canvas, spriteSheet),
        HealthBarRenderingSystem(ctx),
      ]
    };
  }

  @override
  void handleResize() {}

  @override
  void resizeCanvas(CanvasElement canvas) {}
}
