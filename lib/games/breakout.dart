import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:retro_rewind/components/breakout/background_component.dart';
import 'package:retro_rewind/components/breakout/ball_component.dart';
import 'package:retro_rewind/components/breakout/block_set_component.dart';
import 'package:retro_rewind/components/breakout/paddle_component.dart';
import 'package:retro_rewind/components/breakout/ui_component.dart';

/// FlameGame class that is called when the game is launched
class Breakout extends FlameGame
    with KeyboardEvents, HasCollisionDetection, HasTappables {
  // needed to update 'player' movements & player stats
  PaddleComponent paddle = PaddleComponent();
  BallComponent ball = BallComponent();
  UIComponent ui = UIComponent();
  List<BlockSetComponent> level = [];

  // player vars
  int score = 0;
  int lives = 3;

  // Game Loading method. Anything that needs to be added to the scene, like components
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // add necessary game components
    add(BackgroundComponent());
    add(ball);
    add(paddle);

    // generate a random level:
    for (int i = 0; i < 5; i++) {
      level.add(BlockSetComponent(row: i, numBlocks: Random().nextInt(6) + 4));
      add(level[i]);
    }

    // UI added last to appear on top of everything
    await add(ui);
  }

  @override
  void update(double dt) {
    super.update(dt);
    ui.lives.text = "lives: ${lives.toString()}";
    ui.score.text = "score: ${score.toString()}";
    if (lives == 0) {
      ui.gameOverTxt.scale = Vector2(2, 2);
      ui.retryBtn.position = size / 2 + Vector2(0, 180);
    }
  }

  // Key Event Handler for paddle
  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;
    final isKeyUp = event is RawKeyUpEvent;

    if (isKeyDown) {
      if (lives > 0) {
        if (event.data.keyLabel == "a") {
          paddle.moveLeft();
          paddle.isMovingLeft = true;
        }
        if (event.data.keyLabel == "d") {
          paddle.moveRight();
          paddle.isMovingRight = true;
        }
      }
    }
    if (isKeyUp) {
      paddle.isMovingLeft = false;
      paddle.isMovingRight = false;
    }
    return KeyEventResult.handled;
  }

  void resetGame() {
    debugPrint(level.length.toString());
    // remove all blocksets
    for (BlockSetComponent block in level) {
      block.removeFromParent();
    }
    level.clear();
  }
}
