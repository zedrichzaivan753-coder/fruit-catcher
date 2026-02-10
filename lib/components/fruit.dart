import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Fruit extends PositionComponent {
  final String emoji;
  final double speed;

  Fruit({
    required this.emoji,
    required Vector2 position,
    required this.speed,
  }) : super(
    position: position,
    size: Vector2(40, 40),
    anchor: Anchor.center,
  );

  @override
  void update(double dt) {
    super.update(dt);
    // Fall downward
    position.y += speed * dt;
  }

  @override
  void render(Canvas canvas) {
    // Draw emoji fruit centered
    final textPainter = TextPainter(
      text: TextSpan(
        text: emoji,
        style: const TextStyle(fontSize: 40),
      ),
      textDirection: TextDirection.ltr,
    );
    
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, -textPainter.height / 2),
    );
  }
}
