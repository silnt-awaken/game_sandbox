import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:game_sandbox/config/game.dart';

class Bullet extends SpriteComponent with HasGameRef<GameSandbox>, CollisionCallbacks {
  Bullet({required super.position, required Vector2 size, required this.direction, super.angle})
      : super(size: size, anchor: Anchor.center) {
    direction.normalize();
    angle = Vector2(0, -1).angleToSigned(direction);
  }

  final Vector2 direction;
  final double speed = 300;

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('bullet.png');
    add(RectangleHitbox()..collisionType = CollisionType.active);
    lookAt(GameSandbox.mouseVector);
  }

  @override
  void update(double dt) {
    position += direction * speed * dt;

    super.update(dt);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is ScreenHitbox) {
      removeFromParent();
    }
  }
}
