import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:retro_rewind/games/breakout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text("Retro Rewind")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(300, 80, 300, 80),
        child: Card(
          elevation: 30,
          shadowColor: Colors.black,
          color: Colors.grey[300],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: SizedBox(
            height: height,
            width: width,
            child: Center(
              child: GameWidget(
                game: Breakout(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
