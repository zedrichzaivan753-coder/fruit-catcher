# Error Documentation Log - Fruit Catcher Game

## Course Activity: Basic Dart Mobile Application
**Project**: Fruit Catcher Game  
**Date**: February 2026  
**Language**: Dart (Flutter Framework)

---

## Error Log

### Error #1: Invisible Basket

#### 1. Error Details:
- **Error Type**: Rendering/Visibility Bug
- **Error Message**: "Basket component not visible on screen"
- **File**: lib/components/basket.dart
- **Severity**: Critical
- **Description**: The basket was being rendered using absolute positioning without considering the component's anchor point. The code was calculating render coordinates as `position.x - size.x / 2` instead of using local coordinates relative to the anchor point, causing the basket to render at the wrong position off-screen.

#### 2. Detailed Analysis:

**Cause of Error**:
The basket component lacked an anchor point definition, causing Flame to use default positioning. Without `anchor: Anchor.center`, the component's position was calculated incorrectly, placing the basket outside the visible playing area.

**Original Code** (Broken):
```dart
class Basket extends PositionComponent {
  Basket({
    required Vector2 position,
    required Vector2 size,
  }) : super(
    position: position,
    size: size,
    // ❌ Missing anchor definition
  );

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(position.x - size.x / 2, position.y - size.y / 2, ...),
        // ❌ Using absolute positioning instead of local coordinates
        ...
      ),
      paint,
    );
  }
}
```

**Solution Applied**:
Added `anchor: Anchor.center` to the constructor and changed render coordinates to use local space (-size.x/2 to +size.x/2) instead of absolute positioning.

**Fixed Code**:
```dart
class Basket extends PositionComponent {
  Basket({
    required Vector2 position,
    required Vector2 size,
  }) : super(
    position: position,
    size: size,
    anchor: Anchor.center,  // ✅ Added anchor
  );

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(-size.x / 2, -size.y / 2, size.x, size.y),  // ✅ Local coords
        Radius.circular(10),
      ),
      paint,
    );
  }
}
```

**Result**: ✅ Basket now renders correctly and is visible on screen with proper positioning.

---

### Error #2: Non-Functional Touch Input

#### 1. Error Details:
- **Error Type**: Event Handling / API Limitation
- **Error Message**: "'getter 'localPosition' isn't defined'", "'getter 'delta' isn't defined'", "'getter 'globalPosition' isn't defined on DragUpdateEvent'"
- **File**: lib/fruit_catcher_game.dart
- **Severity**: Critical
- **Description**: Attempted to use Flame engine's built-in drag event handlers (`onDragUpdate`). The `DragUpdateEvent` API in Flame 1.10 doesn't expose the properties being accessed (localPosition, delta, globalPosition). The event system was unreliable for continuous movement.

#### 2. Detailed Analysis:

**Cause of Error**:
Flame's DragUpdateEvent class in version 1.10 has a limited API that doesn't include the position properties needed for smooth basket movement. Attempting to access undefined getters on the event object causes compilation errors.

**Original Code** (Broken):
```dart
@override
void onDragUpdate(DragUpdateEvent event) {
  // ❌ These getters don't exist in Flame's DragUpdateEvent
  basket.position.x += event.delta.x;  // ERROR: undefined getter
}

@override
void onDragStart(DragStartEvent event) {
  basket.position.x = event.localPosition.x;  // ERROR: undefined getter
}
```

**Solution Applied**:
Moved from Flame's event system to Flutter's native GestureDetector at the UI layer. This provides reliable and well-documented gesture recognition that works correctly across all platforms.

**Fixed Code**:
```dart
// In main.dart - Flutter layer handles input
GestureDetector(
  onTapDown: (details) {
    _game.moveBasketTo(details.localPosition.dx);  // ✅ Flutter API works reliably
  },
  onPanUpdate: (details) {
    _game.moveBasketTo(details.localPosition.dx);  // ✅ Continuous drag detection
  },
  child: GameWidget(game: _game),
)

// In fruit_catcher_game.dart - public interface for movement
void moveBasketTo(double x) {
  basket.position.x = x;
  _clampBasketPosition();
}
```

**Result**: ✅ Touch input now works reliably for both tap and drag gestures on all platforms.

---

### Error #3: Duplicate Game Over Screen

#### 1. Error Details:
- **Error Type**: Rendering / State Management Bug
- **Error Message**: "GAME OVER text appears twice on screen (overlapped)"
- **File**: lib/fruit_catcher_game.dart and lib/main.dart
- **Severity**: High
- **Description**: The game over screen was being drawn in two places simultaneously - by the Flame game's `render()` method using `_drawGameOver()` and by the Flutter overlay using `Positioned.fill()`. This caused duplicate rendered text and visual confusion.

#### 2. Detailed Analysis:

**Cause of Error**:
Game over screen rendering wasn't properly separated between the Flame game layer and Flutter UI layer, causing two rendering passes that both drew the same content.

**Original Code** (Broken):
```dart
// In fruit_catcher_game.dart
@override
void render(Canvas canvas) {
  super.render(canvas);
  _drawScoreboard(canvas);
  if (isGameOver) {
    _drawGameOver(canvas);  // ❌ Drawing here
  }
}

void _drawGameOver(Canvas canvas) {
  canvas.drawRect(...);
  gameOverStyle.render(canvas, 'GAME OVER', ...);  // ❌ First drawing
}

// In main.dart - Flutter also rendering
if (_game.isGameOver)
  Positioned.fill(
    child: Container(
      child: Text('GAME OVER'),  // ❌ Second drawing - duplicate
    ),
  ),
```

**Solution Applied**:
Removed the `_drawGameOver()` method from the Flame game rendering layer. Let only the Flutter UI layer (which has better control over overlays) handle the game over screen display.

**Fixed Code**:
```dart
// In fruit_catcher_game.dart - Remove canvas drawing
@override
void render(Canvas canvas) {
  super.render(canvas);
  _drawPlayingArea(canvas);
  _drawScoreboard(canvas);
  // ✅ Removed: if (isGameOver) { _drawGameOver(canvas); }
}

// In main.dart - Only Flutter handles overlay
if (_game.isGameOver)
  Positioned.fill(
    child: Container(
      color: Colors.black54,
      child: Center(
        child: Column(...),  // ✅ Single source of truth
      ),
    ),
  ),
```

**Result**: ✅ Game over screen now displays cleanly without duplication.

---

### Error #4: Undefined Variable (basketRect)

#### 1. Error Details:
- **Error Type**: Compilation Error - Undefined Identifier
- **Error Message**: "Undefined name 'basketRect' - lib\fruit_catcher_game.dart:109:5 - undefined_identifier"
- **File**: lib/fruit_catcher_game.dart
- **Lines**: 109 and 116
- **Severity**: Critical
- **Description**: The variable `basketRect` was declared without the `final` keyword, treating it as an undefined variable assignment rather than a variable declaration. In Dart, attempting to assign to an undeclared variable causes an "undefined identifier" error. This is a common mistake when developers forget to include variable declaration keywords.

#### 2. Detailed Analysis:

**Cause of Error**:
Missing the `final` keyword when declaring the basketRect variable. Without this keyword, the code attempts to assign to a non-existent variable, which Dart's type system rejects at compile time.

**Original Code** (Broken):
```dart
bool _isColliding(Fruit fruit) {
  final fruitRect = Rect.fromLTWH(
    fruit.position.x - 20,
    fruit.position.y - 20,
    40,
    40,
  );
  
  basketRect = Rect.fromLTWH(  // ❌ Missing 'final' keyword - undefined variable
    basket.position.x - basket.size.x / 2,
    basket.position.y - basket.size.y / 2,
    basket.size.x,
    basket.size.y,
  );
  
  return fruitRect.overlaps(basketRect);  // ❌ basketRect not defined
}
```

**Solution Applied**:
Added the `final` keyword to properly declare the `basketRect` variable before assigning a value to it.

**Fixed Code**:
```dart
bool _isColliding(Fruit fruit) {
  final fruitRect = Rect.fromLTWH(
    fruit.position.x - 20,
    fruit.position.y - 20,
    40,
    40,
  );
  
  final basketRect = Rect.fromLTWH(  // ✅ Added 'final' keyword
    basket.position.x - basket.size.x / 2,
    basket.position.y - basket.size.y / 2,
    basket.size.x,
    basket.size.y,
  );
  
  return fruitRect.overlaps(basketRect);  // ✅ Now properly defined
}
```

**Result**: ✅ Game compiles and runs successfully. Collision detection works properly.

---

### Error #5: Type Mismatch (String assigned to int)

#### 1. Error Details:
- **Error Type**: Type Assignment Error - Invalid Assignment
- **Error Message**: "A value of type 'String' can't be assigned to a variable of type 'int' - lib\fruit_catcher_game.dart:123:27 - invalid_assignment"
- **File**: lib/fruit_catcher_game.dart
- **Line**: 123
- **Severity**: Critical
- **Description**: Attempted to assign a String value `"5"` to an integer variable `levelDifference`. Dart is a statically-typed language where a String cannot be automatically converted to an int. The type system prevents this incompatible assignment at compile time to catch errors early.

#### 2. Detailed Analysis:

**Cause of Error**:
Type mismatch between String and int. Dart's strict type checking prevents implicit type conversions. When a String is assigned to an int variable without explicit conversion, the compiler rejects the code.

**Original Code** (Broken):
```dart
void _updateDifficulty() {
  int newLevel = (score ~/ 100) + 1;
  
  int levelDifference = "5";  // ❌ ERROR: String literal assigned to int variable
  
  if (newLevel > level) {
    level = newLevel;
    spawnRate = max(0.5, 2.0 - (level * 0.15));
    fruitSpeed = 200.0 + (level * 50);
  }
}
```

**Solution Applied**:
Removed the unnecessary and incorrectly-typed variable. The variable wasn't being used in the code (unused_local_variable warning), so it was simply deleted. If the variable were needed, it should be assigned an integer literal or explicitly converted from String.

**Fixed Code**:
```dart
void _updateDifficulty() {
  int newLevel = (score ~/ 100) + 1;
  
  // ✅ Removed: int levelDifference = "5";  // Incorrect type assignment
  
  if (newLevel > level) {
    level = newLevel;
    spawnRate = max(0.5, 2.0 - (level * 0.15));
    fruitSpeed = 200.0 + (level * 50);
  }
}
```

**Alternative Fix** (if variable was needed):
```dart
// Option 1: Use integer literal
int levelDifference = 5;  // ✅ Correct - integer value

// Option 2: Explicitly convert String to int
int levelDifference = int.parse("5");  // ✅ Correct - explicit conversion
```

**Result**: ✅ Game compiles and runs successfully. Type system enforced correct data type usage.

---

## Summary

| # | Error Type | Message | Severity | Status | Solution |
|---|---|---|---|---|---|
| 1 | Rendering Bug | Basket invisible | Critical | ✅ Fixed | Added anchor point, used local coordinates |
| 2 | Event Handling | Touch unresponsive | Critical | ✅ Fixed | Used Flutter GestureDetector instead of Flame events |
| 3 | State Management | Duplicate game over | High | ✅ Fixed | Single rendering layer (Flutter only) |
| 4 | Undefined Identifier | basketRect not defined | Critical | ✅ Fixed | Added `final` keyword to variable declaration |
| 5 | Type Mismatch | String assigned to int | Critical | ✅ Fixed | Removed incorrect assignment, proper type usage |

**Total Errors Documented**: 5 (exceeds requirement of 3)  
**All Errors**: ✅ Resolved  
**Testing**: ✅ Verified working on Windows, Android emulator, iOS simulator, Web

---

## Lessons Learned

1. **Component Anchoring**: Always set anchor point when using local coordinates in Flame
2. **Event System Limitations**: Flutter's gesture system is more reliable than Flame's for complex input handling
3. **Separation of Concerns**: Keep rendering (Flame) and overlays (Flutter) separate for cleaner code
4. **Testing Across Platforms**: Bugs may appear differently on different platforms - test thoroughly
5. **Type Safety**: Always match variable types - Dart's type system prevents runtime errors
6. **Variable Declaration**: Always use proper keywords (final, var) when declaring variables
7. **API Knowledge**: Understand the APIs you're using - Flame and Flutter have different capabilities

---

## Debugging Tools Used

- **Flutter DevTools**: Widget inspector, performance profiler
- **Flutter Analyze**: Static analysis catching compile errors  
- **VS Code Debugger**: Breakpoints and step-through debugging
- **Print statements**: Console output for tracing execution
- **Hot reload**: Rapid iteration during debugging
- **Device/Emulator testing**: Verified fixes work on actual devices

