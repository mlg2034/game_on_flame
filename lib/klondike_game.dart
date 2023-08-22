import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:game_app/components/foundation.dart';
import 'package:game_app/components/pile.dart';
import 'package:game_app/components/stock.dart';
import 'package:game_app/components/waste.dart';

class KlondikeGame extends FlameGame {
  static const double cardGap = 175.0;
  static const double cardWidth = 1000;
  static const double cardHeight = 1400;
  static const double cardRadius = 100;
  static final Vector2 cardSize = Vector2(cardWidth, cardHeight);
  @override
  Future<void> onLoad() async {
    await Flame.images.load('klondike-sprites.png');
    final stock = Stock()
      ..size = cardSize
      ..position = Vector2(cardGap, cardGap);
    final waste = Waste()
      ..size = cardSize
      ..position = Vector2(cardWidth + 2 * cardGap, cardGap);
    final foundations = List.generate(
      4,
      (index) => Foundation()
        ..size = cardSize
        ..position =
            Vector2((index + 3) * (cardWidth + cardGap) + cardGap, cardGap),
    );
    final piles = List.generate(
      7,
      (index) => Pile()
        ..size = cardSize
        ..position = Vector2(cardGap + index * (cardWidth), cardGap),
    );
    final world = World()
      ..add(stock)
      ..add(waste)
      ..addAll(foundations)
      ..addAll(piles);
    add(world);
    final camera = CameraComponent(world: world)
      ..viewfinder.visibleGameSize =
          Vector2(cardWidth * 7 + cardGap * 8, 4 * cardHeight + 3 * cardGap)
      ..viewfinder.anchor = Anchor.topCenter;
  }

  Sprite klondikeSprite(double x, double y, double width, double height) {
    return Sprite(Flame.images.fromCache('klondike-sprites.png'),
        srcPosition: Vector2(x, y), srcSize: Vector2(width, height));
  }
}
