part of shared;

class Transform extends Component {
  Vector2 pos;
  int orientation;
  Transform(num x, num y, this.orientation) : pos = new Vector2(x.toDouble(), y.toDouble());
}

class Velocity extends Component {
  Vector2 velocity;
  Velocity() : velocity = new Vector2.zero();
  Velocity.of(num x, num y) : velocity = new Vector2(x.toDouble(), y.toDouble());
}

class MovementButton extends Component {
  int jump, left, down, right;
  MovementButton(this.jump, this.left, this.down, this.right);
}

class ActionButton extends Component {
  int shoot;
  ActionButton(this.shoot);
}

class Jumping extends Component {}

class ActionCooldown extends Component {
  double duration = 1000.0;
}

class Health extends Component {
  int health;
  Health(this.health);
}

class HealthBar extends Component {
  Vector2 pos;
  HealthBar(num x, num y) : pos= new Vector2(x.toDouble(), y.toDouble());
}

class Damage extends Component {
  int damage = 1;
}

class BodyDef extends Component {
  Rectangle body;
  String spriteName;
  BodyDef(this.body, this.spriteName);
}

class Player extends Component {
  int player;
  Player(this.player);
}