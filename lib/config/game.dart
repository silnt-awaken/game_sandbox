import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_sandbox/actors/basic.dart';

class GameSandbox extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection {
  GameSandbox();

  late BasicPlayer _player;

  @override
  Future<void> onLoad() async {
    await images.loadAll(['dot.png']);

    _player = BasicPlayer(position: Vector2(128, canvasSize.y - 70));
    addAll([
      ScreenHitbox(),
      _player,
    ]);
  }

  @override
  Color backgroundColor() => Colors.white;
}
