import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snake_game/feature/domain/state.dart';

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier();
});

class GameNotifier extends StateNotifier<GameState> {
  GameNotifier() : super(GameState.Initial());

  static var randomNumber = Random();
  void generateNewFood() {
    state = state.copyWith(
      food: randomNumber.nextInt(700),
    );
  }

  void startGame() {
    state.snakePosition = [45, 65, 85, 105, 125];
    const duration = Duration(microseconds: 300);
    Timer.periodic(duration, (Timer timer) {
      updateSnake();
    });
  }

  void updateSnake() {
    switch (state.direction) {
      case 'down':
        if (state.snakePosition!.last > 740) {
          state.snakePosition!.add(state.snakePosition!.last + 20 - 760);
        } else {
          state.snakePosition!.add(state.snakePosition!.last + 20);
        }

        break;

      case 'up':
        if (state.snakePosition!.last < 20) {
          state.snakePosition!.add(state.snakePosition!.last - 20 + 760);
        } else {
          state.snakePosition!.add(state.snakePosition!.last - 20);
        }

        break;

      case 'left':
        if (state.snakePosition!.last % 20 == 0) {
          state.snakePosition!.add(state.snakePosition!.last - 1 + 20);
        } else {
          state.snakePosition!.add(state.snakePosition!.last - 20);
        }

        break;

      case 'right':
        if ((state.snakePosition!.last + 1) % 20 == 0) {
          state.snakePosition!.add(state.snakePosition!.last + 1 - 20);
        } else {
          state.snakePosition!.add(state.snakePosition!.last + 1);
        }

        break;
    }

    if (state.snakePosition!.last == state.food) {
      generateNewFood();
    } else {
      state.snakePosition!.removeAt(0);
    }
  }

  bool gameOver() {
    for (int i = 0; i < state.snakePosition!.length; i++) {
      int count = 0;
      for (int j = 0; j < state.snakePosition!.length; j++) {
        if (state.snakePosition![i] == state.snakePosition![j]) {
          count += 1;
        }
        if (count == 2) {
          return true;
        }
      }
    }
    return false;
  }

  void showGameOverScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Game Over"),
          content: Text("Your Score" + state.snakePosition!.length.toString()),
          actions: [
            FloatingActionButton(onPressed: () {
              startGame();
              Navigator.of(context).pop();
            })
          ],
        );
      },
    );
  }
}
