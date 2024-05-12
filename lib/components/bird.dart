import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_flappy_bird/game/asset.dart';
import 'package:flame_flappy_bird/game/bird_movement.dart';
import 'package:flame_flappy_bird/game/config.dart';
import 'package:flame_flappy_bird/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Bird();

  int score = 0;

  @override
  Future<void> onLoad() async {
    final birdMid = await gameRef.loadSprite(Asset.birdMidFlap);
    final birdUp = await gameRef.loadSprite(Asset.birdUpFlap);
    final birdDown = await gameRef.loadSprite(Asset.birdDownFlap);

    size = Vector2(50, 40);
    position = Vector2(50, (gameRef.size.y / 2) - (size.y / 2));
    current = BirdMovement.midle;
    sprites = {
      BirdMovement.midle: birdMid,
      BirdMovement.up: birdUp,
      BirdMovement.down: birdDown,
    };

    add(CircleHitbox());
  }

  void fly() {
    add(
      MoveByEffect(
        Vector2(0, Config.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        onComplete: () => current = BirdMovement.down,
      ),
    );
    FlameAudio.play(Asset.flying);
    current = BirdMovement.up;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    gameOver();
  }

  void reset() {
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    score = 0;
  }

  void gameOver() {
    FlameAudio.play(Asset.collision);
    gameRef.isHit = true;
    gameRef.overlays.add('gameOver');
    gameRef.pauseEngine();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += Config.birdVelocity * dt;

    if (position.y < 1) {
      gameOver();
    }
  }
}
