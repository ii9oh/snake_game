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
  Widget build(BuildContext context) {
    final state = ref.watch(gameProvider);
    return Scaffold(
      backgroundColor: Colors.black,
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
              child: Expanded(
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.numberOfSquare,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 20),
                    itemBuilder: (context, index) {
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
                              color: Colors.green,
                            ),
                          ),
                        );
                      }
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
