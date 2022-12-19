import 'package:flame/components.dart';
import 'package:retro_rewind/components/breakout/block_component.dart';
import 'package:retro_rewind/games/breakout.dart';

/// BlockSet Component creates a set of blocks, spaced evenly in a row.
/// It is gives a [row] number and a defined [numBlocks]. and creates a component
/// that can be used to create more complex levels or generate random levels
class BlockSetComponent extends PositionComponent with HasGameRef<Breakout> {
  int row; // the row number in the entire block set (used to calculate blockSet position)
  int numBlocks; // the number of blocks that the row will have
  BlockSetComponent({required this.row, required this.numBlocks});
  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    // Calculate the block width and spacing based on the screen width
    final blockWidth = gameRef.size.x / numBlocks;
    final blockSpacing = (gameRef.size.x - (numBlocks * blockWidth)) / 6;

    // create the parent component
    final parent = PositionComponent(
      position: Vector2(blockWidth / 2, row * 75.0),
      size: Vector2(gameRef.size.x, (gameRef.size.y) * 3 / 5),
      anchor: Anchor.topLeft,
    );

    // Create the blocks and set their positions and add to parent
    List<BlockComponent> blocks = List.generate(
        numBlocks, (i) => BlockComponent(spriteWidth: blockWidth - 42));
    for (int i = 0; i < blocks.length; i++) {
      blocks[i]
          .setPosition(Vector2(blockSpacing * (i + 1) + blockWidth * i, 20));
      parent.add(blocks[i]);
    }

    // add to gameRef
    gameRef.add(parent);
  } // implement : https://www.kodeco.com/35491219-create-a-breakout-game-in-flutter-with-flame-and-forge2d-part-1

}
