import 'dart:math';

class GameState {
  List<int>? snakePosition;
  final int numberOfSquare;
  int? food;
  String? direction;

  GameState({
    this.snakePosition,
    required this.numberOfSquare,
    this.food,
    this.direction,
  });

  factory GameState.Initial() {
    return GameState(
        snakePosition: [45, 65, 85, 105, 125],
        numberOfSquare: 760,
        food: Random().nextInt(700),
        direction: "down");
  }

  GameState copyWith({
    List<int>? snakePosition,
    int? numberOfSquare,
    int? food,
    String? direction,
  }) {
    return GameState(
      snakePosition: snakePosition ?? this.snakePosition,
      numberOfSquare: numberOfSquare ?? this.numberOfSquare,
      food: food ?? this.food,
      direction: direction ?? this.direction,
    );
  }
}
