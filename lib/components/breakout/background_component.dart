import 'package:flame/components.dart';
import 'package:retro_rewind/games/breakout.dart';

import '../../constants/globals.dart';

class BackgroundComponent extends SpriteComponent with HasGameRef<Breakout> {
  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Globals.bgSprite);
    size = gameRef.size;
  }
}
