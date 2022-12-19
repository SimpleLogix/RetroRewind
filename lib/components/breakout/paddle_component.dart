import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:retro_rewind/games/breakout.dart';

import '../../constants/globals.dart';

/// Paddle component is just a basic sprite with movement functions. The movement
/// events aren't handled by components, but instead via keyboard events and results
/// in the main FlameGame class.
class PaddleComponent extends SpriteComponent with HasGameRef<Breakout> {
  final double spriteHeight = 40;
  final double spriteWidth = 180;

  late double leftBound;
  late double rightBound;

  bool isMovingLeft = false;
  bool isMovingRight = false;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());

    // load sprite and set initial size and position
    sprite = await gameRef.loadSprite(Globals.paddleSprite);
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 45);
    height = spriteHeight;
    width = spriteWidth;
    anchor = Anchor.bottomCenter;

    // set bounds
    leftBound =
        10 + spriteWidth / 2; // adding half of the sprite to avoid overflow
    rightBound = gameRef.size.x - 10 - spriteWidth / 2;
  }

  // moves the paddle left
  moveLeft() {
    if (position.x > leftBound) {
      position += Vector2(-18, 0);
    }
  }

  // moves the paddle right
  moveRight() {
    if (position.x < rightBound) {
      position += Vector2(18, 0);
    }
  }
}
