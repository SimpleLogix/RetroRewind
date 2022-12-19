import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retro_rewind/constants/globals.dart';
import 'package:retro_rewind/games/breakout.dart';

class UIComponent extends PositionComponent with HasGameRef<Breakout> {
  late TextComponent lives;
  late TextComponent score;
  late TextComponent gameOverTxt;
  late HudButtonComponent retryBtn;
  late Sprite retryBtnSprite;
  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    retryBtnSprite = await gameRef.loadSprite(Globals.retryBtn);
    lives = TextComponent(
        position: Vector2(15, gameRef.size.y - 15), anchor: Anchor.bottomLeft);
    score = TextComponent(
      position: gameRef.size - Vector2(15, 15),
      anchor: Anchor.bottomRight,
    );
    gameOverTxt = TextComponent(
      text: "Game Over!",
      position: gameRef.size / 2 + Vector2(0, 120), // set off screen
      anchor: Anchor.center,
      scale: Vector2(0, 0),
      textRenderer: TextPaint(
        style: TextStyle(fontSize: 32, color: Colors.red),
      ),
    );
    retryBtn = HudButtonComponent(
      position: gameRef.size / 2 + Vector2(1000, 1000),
      anchor: Anchor.center,
      scale: Vector2(0.75, 0.75),
      button: SpriteComponent(sprite: retryBtnSprite),
      onPressed: () {
        gameRef.resetGame();
      },
    );
    add(lives);
    add(score);
    add(gameOverTxt);
    add(retryBtn);
  }
}
