part of shared;

class Transform extends Component {
  Vector2 pos;
  Transform(num x, num y) : pos = new Vector2(x.toDouble(), y.toDouble());
}

class Velocity extends Component {
  Vector2 velocity;
  Velocity() : velocity = new Vector2.zero();
}

class MovementAction extends Component {
  int jump, left, down, right;
  MovementAction(this.jump, this.left, this.down, this.right);
}

class Jumping extends Component {}