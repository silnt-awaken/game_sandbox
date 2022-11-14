import 'package:bonfire/bonfire.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_sandbox/actors/basic_player.dart';
import 'package:game_sandbox/objects/box.dart';
import 'package:game_sandbox/objects/bullet.dart';

class GameSandbox extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection, MouseMovementDetector, TapDetector {
  GameSandbox();

  late BasicPlayer _player;
  late Bullet _bullet;
  late BoxObject _box;
  late SpriteComponent _background;

  static Vector2 boxPosition = Vector2(0, 0);

  @override
  Future<void> onLoad() async {
    await images.loadAll(['player.png', 'box.png', 'bullet.png', 'background.png']);

    _player = BasicPlayer(position: Vector2(50, 50));
    _box = BoxObject(position: Vector2(canvasSize.x - 90, 50));
    boxPosition = _box.position;
    _background = SpriteComponent()
      ..sprite = await loadSprite('background.png')
      ..size = size;

    addAll([_background, ScreenHitbox(), _box, _player]);
  }

  @override
  Color backgroundColor() => Colors.white;

  @override
  void onMouseMove(PointerHoverInfo info) {
    final mouseVector = _player.gameRef.camera.screenToWorld(info.eventPosition.global);
    _player.lookAt(mouseVector);
  }

  static Vector2 mouseVector = Vector2.zero();

  @override
  void onTapDown(TapDownInfo info) {
    mouseVector = _player.gameRef.camera.screenToWorld(info.eventPosition.global);
    _bullet = Bullet(
      position: Vector2(_player.position.x, _player.position.y - 10),
      size: Vector2(32, 64),
      direction: (_player.gameRef.camera.screenToWorld(info.eventPosition.global) - _player.position),
    );
    add(_bullet);
    super.onTapDown(info);
  }
}
