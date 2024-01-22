import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snake_game/feature/domain/controller.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  @override
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(gameProvider);
    final controller = ref.read(gameProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.black26,
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (state.direction != 'up' && details.delta.dy > 0) {
                  state.direction = 'down';
                } else if (state.direction != 'down' && details.delta.dy < 0) {
                  state.direction = 'up';
                }
              },
              onHorizontalDragUpdate: (details) {
                if (state.direction != 'left' && details.delta.dx > 0) {
                  state.direction = 'right';
                } else if (state.direction != 'right' && details.delta.dx < 0) {
                  state.direction = 'left';
                }
              },
              child: Container(
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.numberOfSquare,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 20),
                    itemBuilder: (BuildContext context, int index) {
                      if (state.snakePosition!.contains(index)) {
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }
                      if (index == state.food) {
                        return Container(
                          padding: const EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              color: Colors.greenAccent,
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              color: Colors.grey[900],
                            ),
                          ),
                        );
                      }
                    }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.startGame(context);
                      print("play");
                    },
                    child: const Text(
                      "Start",
                      style: TextStyle(fontSize: 39, color: Colors.white),
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
