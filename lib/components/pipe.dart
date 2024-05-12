import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_flappy_bird/game/asset.dart';
import 'package:flame_flappy_bird/game/config.dart';
import 'package:flame_flappy_bird/game/flappy_bird_game.dart';
import 'package:flame_flappy_bird/game/pipe_position.dart';

class Pipe extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  @override
  final double height;
  final PipePosition pipePosition;

  Pipe({required this.height, required this.pipePosition});

  @override
  Future<void> onLoad() async {
    final pipe = await Flame.images.load(Asset.pipe);
    final pipeRotated = await Flame.images.load(Asset.pipeRotated);
    size = Vector2(50, height);

    switch (pipePosition) {
      case PipePosition.top:
        position.y = 0;
        sprite = Sprite(pipeRotated);
        break;
      case PipePosition.bottom:
        position.y = gameRef.size.y - size.y - Config.groundHeight;
        sprite = Sprite(pipe);
        break;
    }

    add(RectangleHitbox());
  }
}
