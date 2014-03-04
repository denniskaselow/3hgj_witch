part of client;

class EntityRenderingSysteme extends EntityProcessingSystem {
  ComponentMapper<Transform> tm;
  ComponentMapper<BodyDef> bm;
  CanvasRenderingContext2D ctx;
  SpriteSheet sheet;
  EntityRenderingSysteme(CanvasElement canvas, this.sheet) :
    ctx = canvas.context2D,
    super(Aspect.getAspectForAllOf([Transform, BodyDef]));


  @override
  void processEntity(Entity entity) {
    var t = tm.get(entity);
    var b = bm.get(entity);
    var sprite = sheet.sprites[b.spriteName];
    ctx.drawImageToRect(sheet.image, new Rectangle(t.pos.x + sprite.offset.x, t.pos.y + sprite.offset.y, sprite.dst.width, sprite.dst.height), sourceRect: sheet.sprites[b.spriteName].src);

  }
}

class HealthBarRenderingSystem extends EntityProcessingSystem {
  ComponentMapper<Health> hm;
  ComponentMapper<HealthBar> hbm;
  CanvasRenderingContext2D ctx;
  HealthBarRenderingSystem(this.ctx) : super(Aspect.getAspectForAllOf([Health, HealthBar]));


  @override
  void processEntity(Entity entity) {
    var h = hm.get(entity);
    var hb = hbm.get(entity);
    ctx..strokeStyle = 'black'
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
    ctx.drawImageToRect(sheet.image, new Rectangle(0, 0, 800, 600), sourceRect: sheet.sprites['bg.png'].src);
  }
}