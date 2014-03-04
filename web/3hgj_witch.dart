import 'package:3hgj_witch/client.dart';

@MirrorsUsed(targets: const [EntityRenderingSysteme
                            ])
import 'dart:mirrors';

void main() {
  new Game().start();
}

class Game extends GameBase {

  Game() : super.noAssets('3hgj_witch', 'canvas', 800, 600);

  void createEntities() {
    addEntity([new Transform(100, 500)]);
    addEntity([new Transform(700, 500)]);
  }

  List<EntitySystem> getSystems() {
    return [
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

