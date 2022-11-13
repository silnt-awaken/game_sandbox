import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_sandbox/config/game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const GameWidget<GameSandbox>.controlled(gameFactory: GameSandbox.new));
}
