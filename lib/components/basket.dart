import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Basket extends PositionComponent {
  Basket({
    required Vector2 position,
    required Vector2 size,
  }) : super(
    position: position,
    size: size,
    anchor: Anchor.center,
  );

  @override
  void render(Canvas canvas) {
    // Draw basket background - use local coordinates (0,0) as component center
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          -size.x / 2,
          -size.y / 2,
          size.x,
          size.y,
        ),
        const Radius.circular(8),
      ),
      Paint()..color = const Color.fromARGB(255, 139, 69, 19), // Brown
    );
    
    // Draw basket outline
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          -size.x / 2,
          -size.y / 2,
          size.x,
          size.y,
        ),
        const Radius.circular(8),
      ),
      Paint()
        ..color = Colors.orange
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    
    // Draw basket pattern (weave effect)
    for (int i = 1; i < 3; i++) {
      canvas.drawLine(
        Offset(-size.x / 2 + i * 15, -size.y / 2),
        Offset(-size.x / 2 + i * 15, size.y / 2),
        Paint()
          ..color = Colors.orange.withValues(alpha: 0.5)
          ..strokeWidth = 1,
      );
    }
  }
}
