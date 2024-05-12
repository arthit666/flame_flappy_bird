import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_flappy_bird/game/flappy_bird_game.dart';
import 'package:flame_flappy_bird/screens/game_over_screen.dart';
import 'package:flame_flappy_bird/screens/main_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();

  final game = FlappyBirdGame();
  runApp(
    GameWidget(
      game: game,
      initialActiveOverlays: const [MainMenuScreen.id],
      overlayBuilderMap: {
        'mainMenu': (context, _) => MainMenuScreen(game: game),
        'gameOver': (context, _) => GameOverScreen(game: game),
      },
    ),
  );
}
