import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:retro_rewind/components/breakout/ball_component.dart';
import 'package:retro_rewind/games/breakout.dart';

import '../../constants/globals.dart';

/// The smallest component making up the level. Each block component is independant of
/// each other and is responsible for keeping track of hits, and collision detection
class BlockComponent extends SpriteComponent
    with CollisionCallbacks, HasGameRef<Breakout> {
  final double spriteHeight = 50;
  double spriteWidth;

  late Sprite block;
  late Sprite brokenBlock;

  int hits = 0; // number of hits by ball

  BlockComponent({required this.spriteWidth});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());

    block = await gameRef.loadSprite(Globals.blockSprite);
    brokenBlock = await gameRef.loadSprite(Globals.brokenBlockSprite);

    sprite = block;
    height = spriteHeight;
    width = spriteWidth;
    anchor = Anchor.topCenter;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is BallComponent) {
      hits++;
      if (hits == 1) {
        sprite = brokenBlock;
      }
      if (hits == 2) {
        removeFromParent();
      }
    }
  }

  void setPosition(Vector2 pos) {
    position = pos;
  }

  void destroy() {
    removeFromParent();
  }
}
