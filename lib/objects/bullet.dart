import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:game_sandbox/config/game.dart';

class Bullet extends SpriteComponent with HasGameRef<GameSandbox>, CollisionCallbacks {
  Bullet({required super.position, required Vector2 size}) : super(size: size, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('bullet.png');
    add(RectangleHitbox());
    lookAt(GameSandbox.mouseVector);
  }

  @override
  void update(double dt) {
    _shootInDirection(dt);

    super.update(dt);
  }

  void _shootInDirection(double dt) {
    final direction = GameSandbox.mouseVector - position;
    final normalizedDirection = direction.normalized();
    final velocity = normalizedDirection * 3000 * dt;
    position += velocity;

    if (position.distanceTo(GameSandbox.mouseVector) < 20) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is ScreenHitbox) {
      removeFromParent();
    }
  }
}

extension Vector2Extension on Vector2 {
  double fromAngle({required double angle, required double distance}) {
    return atan2(angle, distance);
  }
}
