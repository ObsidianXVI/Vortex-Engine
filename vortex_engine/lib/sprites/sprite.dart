part of vortex_engine;

abstract class Sprite extends Widget {
  final SpriteImage baseImage;
  final String spriteId = 'spriteId';
  final double width;
  final double height;
  final Position? position;

  const Sprite({
    required this.baseImage,
    required this.width,
    required this.height,
    required this.position,
  });

  bool hasFocus(VortexCanvas canvas) => canvas.activeSprite == this;

  @override
  bool operator ==(Object other) {
    if (other is! Sprite) {
      return false;
    } else {
      if (other.spriteId == spriteId) {
        return true;
      } else {
        return false;
      }
    }
  }
}

class StaticSprite extends StatelessWidget implements Sprite {
  @override
  final SpriteImage baseImage;
  @override
  final String spriteId = 'spriteId';
  @override
  final double width;
  @override
  final double height;
  @override
  final Position? position;

  const StaticSprite({
    required this.baseImage,
    required this.width,
    required this.height,
    required this.position,
    super.key,
  });

  @override
  bool hasFocus(VortexCanvas canvas) => canvas.activeSprite == this;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: position?.y,
      left: position?.x,
      child: SizedBox(
        width: width,
        height: height,
        child: baseImage,
      ),
    );
  }
}

abstract class StatefulSprite extends StatefulWidget implements Sprite {
  @override
  final SpriteImage baseImage;
  @override
  final String spriteId = 'spriteId';
  @override
  final double width;
  @override
  final double height;
  @override
  final Position? position;

  const StatefulSprite({
    required this.baseImage,
    required this.width,
    required this.height,
    required this.position,
    super.key,
  });

  @override
  bool hasFocus(VortexCanvas canvas) => canvas.activeSprite == this;

  @override
  SpriteController createState();
}

abstract class SpriteController<T extends StatefulSprite> extends State<T> {
  SpriteController();
}

class AnimatedSprite extends StatefulSprite {
  final Loop<SpriteImage> frames;
  final Duration refreshInterval;
  const AnimatedSprite({
    required this.refreshInterval,
    required this.frames,
    required super.baseImage,
    required super.width,
    required super.height,
    required super.position,
    super.key,
  });

  @override
  AnimatedSpriteController createState() => AnimatedSpriteController();
}

class AnimatedSpriteController extends SpriteController<AnimatedSprite> {
  late Timer refreshTimer;

  AnimatedSpriteController();

  @override
  void initState() {
    refreshTimer = Timer.periodic(widget.refreshInterval, (timer) {
      setState(() => widget.frames.next());
    });
    super.initState();
  }

  @override
  void dispose() {
    refreshTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.position?.y,
      left: widget.position?.x,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: widget.frames.current(),
      ),
    );
  }
}

class ControllableSprite extends StatefulSprite {
  const ControllableSprite({
    required super.baseImage,
    required super.width,
    required super.height,
    required super.position,
    super.key,
  });

  @override
  ControllableSpriteController createState() => ControllableSpriteController();
}

class ControllableSpriteController
    extends SpriteController<ControllableSprite> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.position?.y,
      left: widget.position?.x,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: widget.baseImage,
      ),
    );
  }
}

class KeyboardControllableSprite extends ControllableSprite {
  final double stepSize;
  const KeyboardControllableSprite({
    required this.stepSize,
    required super.baseImage,
    required super.width,
    required super.height,
    required super.position,
    super.key,
  });

  @override
  KBControllableSpriteController createState() =>
      KBControllableSpriteController(
        stepSize: stepSize,
      );
}

class KBControllableSpriteController extends ControllableSpriteController {
  final double stepSize;
  late Stream<KeyEvent> keyEventStream;

  KBControllableSpriteController({
    required this.stepSize,
  });

  @override
  void initState() {
    keyEventStream = KeyboardService.requestFor(widget);
    keyEventStream.listen((KeyEvent keyEvent) {
      if (keyEvent.logicalKey == LogicalKeyboardKey.arrowUp) {
        widget.position?.translate(0, -stepSize);
        setState(() {});
      } else if (keyEvent.logicalKey == LogicalKeyboardKey.arrowDown) {
        widget.position?.translate(0, stepSize);
        setState(() {});
      } else if (keyEvent.logicalKey == LogicalKeyboardKey.arrowLeft) {
        widget.position?.translate(-stepSize, 0);
        setState(() {});
      } else if (keyEvent.logicalKey == LogicalKeyboardKey.arrowRight) {
        widget.position?.translate(stepSize, 0);
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutQuart,
      top: widget.position?.y,
      left: widget.position?.x,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: widget.baseImage,
      ),
    );
  }
}
