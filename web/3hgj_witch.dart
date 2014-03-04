import 'package:3hgj_witch/client.dart';

@MirrorsUsed(targets: const [EntityRenderingSysteme, MovementSystem,
                             MovementHandlingSystem, InputEventListeningSystem,
                             GravitySystem, ActionHandlingSysteme,
                             HealthBarRenderingSystem, CollisionDetectionSystem,
                             CollisionHandlingSystem
                            ])
import 'dart:mirrors';

void main() {
  new Game().start();
}

class Game extends GameBase {

  Game() : super('3hgj_witch', 'canvas', 800, 600, bodyDefsName: null);

  void createEntities() {
    addEntity([new Transform(100, 450, 1),
               new BodyDef(new Rectangle(-20, -100, 40, 200), 'witch.png'),
               new Velocity(),
               new MovementButton(KeyCode.W, KeyCode.A, KeyCode.S, KeyCode.D),
               new ActionButton(KeyCode.J),
               new Health(10),
               new HealthBar(200, 100),
               new Player(1)]);
    addEntity([new Transform(700, 450, -1),
               new BodyDef(new Rectangle(-50, -100, 100, 200), 'fairy.png'),
               new Velocity(),
               new MovementButton(KeyCode.UP, KeyCode.LEFT, KeyCode.DOWN, KeyCode.RIGHT),
               new ActionButton(KeyCode.NUM_ONE),
               new Health(10),
               new HealthBar(600, 100),
               new Player(2)]);
  }

  List<EntitySystem> getSystems() {
    return [
            new InputEventListeningSystem(),
            new MovementHandlingSystem(),
            new GravitySystem(),
            new MovementSystem(),
            new ActionHandlingSysteme(),
            new ActionCooldownSystem(),
            new CollisionDetectionSystem(),
            new CollisionHandlingSystem(),
            new CanvasCleaningSystem(canvas),
            new BackgroundRenderingSystem(ctx, spriteSheet),
            new EntityRenderingSysteme(canvas, spriteSheet),
            new HealthBarRenderingSystem(ctx),
    ];
  }

  Future onInit() {
  }

  Future onInitDone() {
  }
}

