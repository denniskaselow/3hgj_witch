part of client;

class EntityRenderingSysteme extends EntityProcessingSystem {
  ComponentMapper<Transform> tm;
  ComponentMapper<BodyDef> bm;
  CanvasRenderingContext2D ctx;
  EntityRenderingSysteme(CanvasElement canvas) :
    ctx = canvas.context2D,
    super(Aspect.getAspectForAllOf([Transform, BodyDef]));


  @override
  void processEntity(Entity entity) {
    var t = tm.get(entity);
    var b = bm.get(entity);
    ctx..fillStyle = 'black'
       ..fillRect(t.pos.x + b.body.left, t.pos.y + b.body.top, b.body.width, b.body.height);

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