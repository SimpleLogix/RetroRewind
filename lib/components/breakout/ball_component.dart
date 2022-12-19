import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:retro_rewind/components/breakout/block_component.dart';
import 'package:retro_rewind/components/breakout/paddle_component.dart';
import 'package:retro_rewind/constants/globals.dart';
import 'package:retro_rewind/games/breakout.dart';

/// Ball component which implements some basic math-based physics and does most
/// of the bound-checking.
class BallComponent extends SpriteComponent
    with CollisionCallbacks, HasGameRef<Breakout> {
  final double spriteHeight = 35;
  final double spriteWidth = 35;

  late double leftBound;
  late double rightBound;
  late double lowerBound;

  double yVelocity = 400;
  double xVelocity = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(CircleHitbox());

    sprite = await gameRef.loadSprite(Globals.ballSprite);
    position = gameRef.size / 2; //middle of screen
    height = spriteHeight;
    width = spriteWidth;
    anchor = Anchor.center;

    leftBound = 0 + spriteWidth / 2;
    rightBound = gameRef.size.x - spriteWidth / 2;
    lowerBound = gameRef.size.y + 25;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is PaddleComponent) {
      if (other.isMovingLeft) {
        xVelocity = 100;
        debugPrint(intersectionPoints.first.toString());
      } else if (other.isMovingRight) {
        xVelocity = -100;
        debugPrint(intersectionPoints.first.toString());
      }
      yVelocity *= -1;
      position += Vector2(1, 1);
      position -= Vector2(1, 1);
      other.position.y--;
      other.position.y++;
    }
    // if colliding with block
    if (other is BlockComponent) {
      yVelocity *= -1;
      gameRef.score += 50;
    }
  }

  @override
  void update(double t) {
    if (gameRef.lives > 0){
if (position.y < 25) {
      // if ball hits top of screen
      yVelocity *= -1;
    }
    if (position.x <= leftBound) {
      //ball hit left bound
      xVelocity *= -1;
    }
    if (position.x >= rightBound) {
      // ball hits right bount
      xVelocity *= -1;
    }
    if (position.y > lowerBound) {
      // reset ball and update lives
      position = gameRef.size / 2;
      gameRef.lives--;
      gameRef.camera.shake(intensity: 10);
    }
    position.y += yVelocity * t;
    position.x += xVelocity * t;
  }
    }
    
}
