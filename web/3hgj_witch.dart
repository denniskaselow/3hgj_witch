import 'package:3hgj_witch/client.dart';

@MirrorsUsed(targets: const [EntityRenderingSysteme, MovementSystem,
                             MovementHandlingSystem, InputEventListeningSystem,
                             GravitySystem
                            ])
import 'dart:mirrors';

void main() {
  new Game().start();
}

class Game extends GameBase {

  Game() : super.noAssets('3hgj_witch', 'canvas', 800, 600);

  void createEntities() {
    addEntity([new Transform(100, 500), new Velocity(), new MovementAction(KeyCode.W, KeyCode.A, KeyCode.S, KeyCode.D)]);
    addEntity([new Transform(700, 500), new Velocity(), new MovementAction(KeyCode.UP, KeyCode.LEFT, KeyCode.DOWN, KeyCode.RIGHT)]);
  }

  List<EntitySystem> getSystems() {
    return [
            new InputEventListeningSystem(),
            new MovementHandlingSystem(),
            new GravitySystem(),
            new MovementSystem(),
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

