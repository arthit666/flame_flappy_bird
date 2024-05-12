import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_flappy_bird/game/asset.dart';
import 'package:flame_flappy_bird/game/flappy_bird_game.dart';

class Background extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  Background();

  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load(Asset.backgorund);
    size = gameRef.size;
    sprite = Sprite(background);
  }
}
