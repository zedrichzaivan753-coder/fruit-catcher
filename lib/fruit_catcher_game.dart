import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'components/fruit.dart';
import 'components/basket.dart';

class FruitCatcherGame extends FlameGame {
  late Basket basket;
  final List<Fruit> fruits = [];
  
  int score = 0;
  int level = 1;
  double spawnRate = 2.0;
  double fruitSpeed = 200.0;
  
  int missedCount = 0; // Track consecutive missed fruits
  bool isGameOver = false;
  
  // Playing area boundaries - calculated as center-aligned, 80% of screen width
  late double PLAY_AREA_LEFT;
  late double PLAY_AREA_WIDTH;
  
  void _initializePlayingArea() {
    PLAY_AREA_WIDTH = size.x * 0.8; // 80% of screen width
    PLAY_AREA_LEFT = (size.x - PLAY_AREA_WIDTH) / 2; // Center it
  }
  
  double spawnTimer = 0;
  final Random random = Random();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    _initializePlayingArea();
    
    basket = Basket(
      position: Vector2(PLAY_AREA_LEFT + PLAY_AREA_WIDTH / 2, size.y - 50),
      size: Vector2(60, 40),
    );
    add(basket);
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    if (isGameOver) return; // Stop updating if game is over
    
    // Spawn fruits
    spawnTimer += dt;
    if (spawnTimer >= spawnRate) {
      _spawnFruit();
      spawnTimer = 0;
    }
    
    // Update fruits and check for collisions
    for (int i = fruits.length - 1; i >= 0; i--) {
      Fruit fruit = fruits[i];
      
      // Check if fruit is caught
      if (_isColliding(fruit)) {
        fruits.removeAt(i);
        score += 10 * level;
        missedCount = 0; // Reset missed counter on successful catch
        _updateDifficulty();
        continue;
      }
      
      // Remove fruit if it goes off screen (missed)
      if (fruit.position.y > size.y) {
        fruits.removeAt(i);
        missedCount++;
        
        // Check for game over
        if (missedCount >= 10) {
          isGameOver = true;
        }
      }
    }
  }

  void _spawnFruit() {
    final fruitTypes = ['🍎', '🍌', '🍊', '🍇', '🍓'];
    final randomType = fruitTypes[random.nextInt(fruitTypes.length)];
    // Spawn fruits only within the playing area, accounting for fruit size
    final randomX = PLAY_AREA_LEFT + 20 + random.nextDouble() * (PLAY_AREA_WIDTH - 40);
    
    final fruit = Fruit(
      emoji: randomType,
      position: Vector2(randomX, -30),
      speed: fruitSpeed,
    );
    
    fruits.add(fruit);
    add(fruit);
  }

  bool _isColliding(Fruit fruit) {
    final fruitRect = Rect.fromLTWH(
      fruit.position.x - 20,
      fruit.position.y - 20,
      40,
      40,
    );
    
    final basketRect = Rect.fromLTWH(
      basket.position.x - basket.size.x / 2,
      basket.position.y - basket.size.y / 2,
      basket.size.x,
      basket.size.y,
    );
    
    return fruitRect.overlaps(basketRect);
  }

  void _updateDifficulty() {
    // Increase difficulty based on score
    int newLevel = (score ~/ 100) + 1;
    
    if (newLevel > level) {
      level = newLevel;
      spawnRate = max(0.5, 2.0 - (level * 0.15)); // Fruits spawn faster
      fruitSpeed = 200.0 + (level * 50); // Fruits fall faster
      
      // Switch statement to provide difficulty feedback/description
      String difficultyName = _getDifficultyName(level);
      print('🎮 Level $level reached! Difficulty: $difficultyName');
    }
  }
  
  // Switch statement to determine difficulty level name
  String _getDifficultyName(int level) {
    switch (level) {
      case 1:
        return 'Easy';
      case 2:
        return 'Medium';
      case 3:
        return 'Hard';
      case 4:
        return 'Very Hard';
      case 5:
        return 'Extreme';
      default:
        return 'Insane (Level $level)';
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    basket.position.x = event.localPosition.x;
    _clampBasketPosition();
  }

  @override
  void onDragStart(DragStartEvent event) {
    basket.position.x = event.localPosition.x;
    _clampBasketPosition();
  }

  @override
  void onDragEnd(DragEndEvent event) {
    // End drag
  }

  // Public method called from Flutter's GestureDetector
  void moveBasketTo(double x) {
    basket.position.x = x;
    _clampBasketPosition();
  }

  void _clampBasketPosition() {
    // Restrict basket to playing area
    basket.position.x = basket.position.x.clamp(
      PLAY_AREA_LEFT + basket.size.x / 2,
      PLAY_AREA_LEFT + PLAY_AREA_WIDTH - basket.size.x / 2,
    );
  }
  
  // Reset game for new play
  void resetGame() {
    score = 0;
    level = 1;
    spawnRate = 2.0;
    fruitSpeed = 200.0;
    missedCount = 0;
    isGameOver = false;
    spawnTimer = 0;
    fruits.clear();
    removeWhere((component) => component is Fruit);
    basket.position = Vector2(PLAY_AREA_LEFT + PLAY_AREA_WIDTH / 2, size.y - 50);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // Draw playing area boundaries
    _drawPlayingArea(canvas);
    
    // Draw scoreboard
    _drawScoreboard(canvas);
  }
  
  void _drawPlayingArea(Canvas canvas) {
    // Draw vertical lines to mark playing area
    final paint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 2;
    
    // Left boundary
    canvas.drawLine(
      Offset(PLAY_AREA_LEFT, 0),
      Offset(PLAY_AREA_LEFT, size.y),
      paint,
    );
    
    // Right boundary
    canvas.drawLine(
      Offset(PLAY_AREA_LEFT + PLAY_AREA_WIDTH, 0),
      Offset(PLAY_AREA_LEFT + PLAY_AREA_WIDTH, size.y),
      paint,
    );
  }

  void _drawScoreboard(Canvas canvas) {
    final textStyle = TextPaint(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
    
    final smallTextStyle = TextPaint(
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 16,
      ),
    );
    
    // Background for scoreboard
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(10, 10, 250, 100),
        const Radius.circular(10),
      ),
      Paint()..color = Colors.black54,
    );
    
    // Score
    textStyle.render(canvas, 'Score: $score', Vector2(25, 25));
    
    // Level
    smallTextStyle.render(canvas, 'Level: $level', Vector2(25, 50));
    
    // Spawn rate indicator
    smallTextStyle.render(
      canvas,
      'Spawn: ${spawnRate.toStringAsFixed(2)}s',
      Vector2(25, 70),
    );
    
    // Missed count
    final missedColor = missedCount >= 8 ? Colors.red : Colors.white70;
    final missedStyle = TextPaint(
      style: TextStyle(
        color: missedColor,
        fontSize: 16,
        fontWeight: missedCount >= 8 ? FontWeight.bold : FontWeight.normal,
      ),
    );
    
    missedStyle.render(
      canvas,
      'Missed: $missedCount/10',
      Vector2(25, 90),
    );
  }
}
