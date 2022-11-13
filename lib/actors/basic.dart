import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:game_sandbox/config/game.dart';

class BasicPlayer extends SpriteComponent with KeyboardHandler, HasGameRef<GameSandbox>, CollisionCallbacks {
  BasicPlayer({required super.position})
      : super(
          size: Vector2.all(32),
          anchor: Anchor.center,
        );

  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 200;
  int horizontalDirection = 0;
  int verticalDirection = 0;

  @override
  void update(double dt) {
    velocity.x = horizontalDirection * moveSpeed;
    velocity.y = verticalDirection * moveSpeed;
    position += velocity * dt;

    super.update(dt);
  }

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('dot.png');
    add(RectangleHitbox());
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalDirection = 0;
    horizontalDirection +=
        (keysPressed.contains(LogicalKeyboardKey.keyA) || keysPressed.contains(LogicalKeyboardKey.arrowLeft)) ? -1 : 0;
    horizontalDirection +=
        (keysPressed.contains(LogicalKeyboardKey.keyD) || keysPressed.contains(LogicalKeyboardKey.arrowRight)) ? 1 : 0;

    verticalDirection = 0;
    verticalDirection +=
        (keysPressed.contains(LogicalKeyboardKey.keyW) || keysPressed.contains(LogicalKeyboardKey.arrowUp)) ? -1 : 0;
    verticalDirection +=
        (keysPressed.contains(LogicalKeyboardKey.keyS) || keysPressed.contains(LogicalKeyboardKey.arrowDown)) ? 1 : 0;
    return true;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is ScreenHitbox) {
      print('Collision with screen edge detected!');
      position = Vector2(50, 50);
    }
  }
}
