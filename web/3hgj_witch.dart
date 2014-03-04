import 'package:3hgj_witch/client.dart';

@MirrorsUsed(targets: const [EntityRenderingSysteme, MovementSystem,
                             MovementHandlingSystem, InputEventListeningSystem,
                             GravitySystem, ActionHandlingSysteme
                            ])
import 'dart:mirrors';

void main() {
  new Game().start();
}

class Game extends GameBase {

  Game() : super.noAssets('3hgj_witch', 'canvas', 800, 600);

  void createEntities() {
    addEntity([new Transform(100, 500, 1),
               new Velocity(),
               new MovementButton(KeyCode.W, KeyCode.A, KeyCode.S, KeyCode.D),
               new ActionButton(KeyCode.J)]);
    addEntity([new Transform(700, 500, -1),
               new Velocity(),
               new MovementButton(KeyCode.UP, KeyCode.LEFT, KeyCode.DOWN, KeyCode.RIGHT),
               new ActionButton(KeyCode.NUM_ONE)]);
  }

  List<EntitySystem> getSystems() {
    return [
            new InputEventListeningSystem(),
            new MovementHandlingSystem(),
            new GravitySystem(),
            new MovementSystem(),
            new ActionHandlingSysteme(),
            new ActionCooldownSystem(),
            new CanvasCleaningSystem(canvas),
            new EntityRenderingSysteme(canvas),
            new FpsRenderingSystem(ctx)
    ];
  }

  Future onInit() {
  }

  Future onInitDone() {
  }
}

