import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:game_sandbox/actors/basic_player.dart';

import '../config/game.dart';
import 'bullet.dart';

class BoxObject extends SpriteComponent with HasGameRef<GameSandbox>, CollisionCallbacks {
  BoxObject({required super.position})
      : super(
          size: Vector2.all(32),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('box.png');
    add(RectangleHitbox());
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is BasicPlayer) {
      gameRef.add(PositionComponent()
        ..position = position
        ..size = size);
    }

    if (other is Bullet) {
      removeFromParent();
    }
  }
}
