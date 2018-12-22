import 'dart:html';

import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers.dart';
import 'package:thgj_witch/shared.dart';

part 'rendering.g.dart';

@Generate(
  EntityProcessingSystem,
  allOf: [
    Transform,
    BodyDef,
  ],
)
class EntityRenderingSysteme extends _$EntityRenderingSysteme {
  CanvasRenderingContext2D ctx;
  SpriteSheet sheet;
  EntityRenderingSysteme(CanvasElement canvas, this.sheet)
      : ctx = canvas.context2D,
        super();

  @override
  void processEntity(Entity entity) {
    var t = transformMapper[entity];
    var b = bodyDefMapper[entity];
    var sprite = sheet.sprites[b.spriteName];
    ctx.drawImageToRect(
        sheet.image,
        Rectangle(t.pos.x + sprite.offset.x, t.pos.y + sprite.offset.y,
            sprite.dst.width, sprite.dst.height),
        sourceRect: sheet.sprites[b.spriteName].src);
  }
}

@Generate(
  EntityProcessingSystem,
  allOf: [
    Health,
    HealthBar,
  ],
)
class HealthBarRenderingSystem extends _$HealthBarRenderingSystem {
  CanvasRenderingContext2D ctx;
  HealthBarRenderingSystem(this.ctx) : super();

  @override
  void processEntity(Entity entity) {
    var h = healthMapper[entity];
    var hb = healthBarMapper[entity];
    ctx
      ..strokeStyle = 'black'
      ..fillStyle = 'red'
      ..lineWidth = 5
      ..strokeRect(hb.pos.x - 150, hb.pos.y - 10, 300, 20)
      ..fillRect(hb.pos.x - 150, hb.pos.y - 10, 300, 20)
      ..fillStyle = 'green'
      ..fillRect(hb.pos.x - 150, hb.pos.y - 10, h.health * 30, 20);
  }
}

class BackgroundRenderingSystem extends VoidEntitySystem {
  CanvasRenderingContext2D ctx;
  SpriteSheet sheet;
  BackgroundRenderingSystem(this.ctx, this.sheet);

  @override
  void processSystem() {
    ctx.drawImageToRect(sheet.image, Rectangle(0, 0, 800, 600),
        sourceRect: sheet.sprites['bg.png'].src);
  }
}
