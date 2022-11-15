import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_sandbox/config/game.dart';
import 'package:game_sandbox/widgets/secure_progress_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // set the game's sizej

  runApp(GameWidget<GameSandbox>.controlled(
    gameFactory: GameSandbox.new,
    overlayBuilderMap: {
      'secure_progress_bar': (context, game) => const Positioned(right: 440, top: 450, child: SecureProgressBar())
    },
    initialActiveOverlays: const ['secure_progress_bar'],
  ));
}
