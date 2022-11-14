import 'package:bonfire/bonfire.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_sandbox/actors/basic_player.dart';
import 'package:game_sandbox/objects/box.dart';

class GameSandbox extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection, MouseMovementDetector {
  GameSandbox();

  late BasicPlayer _player;
  late BoxObject _box;

  @override
  Future<void> onLoad() async {
    await images.loadAll(['player.png', 'box.png']);

    _player = BasicPlayer(position: Vector2(50, 50));
    _box = BoxObject(position: Vector2(100, 100));
    addAll([
      ScreenHitbox(),
      _player,
      _box,
    ]);
  }

  @override
  Color backgroundColor() => Colors.white;

  @override
  void onMouseMove(PointerHoverInfo info) {
    final mouseVector = _player.gameRef.camera.screenToWorld(info.eventPosition.global);
    _player.lookAt(mouseVector);
  }
}
