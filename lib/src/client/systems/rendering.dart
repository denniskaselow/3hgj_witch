part of client;

class EntityRenderingSysteme extends EntityProcessingSystem {
  ComponentMapper<Transform> tm;
  CanvasRenderingContext2D ctx;
  EntityRenderingSysteme(CanvasElement canvas) :
    ctx = canvas.context2D,
    super(Aspect.getAspectForAllOf([Transform]));


  @override
  void processEntity(Entity entity) {
    var t = tm.get(entity);
    ctx..fillStyle = 'black'
       ..fillRect(t.pos.x - 10, t.pos.y - 40, 20, 80);

  }
}
