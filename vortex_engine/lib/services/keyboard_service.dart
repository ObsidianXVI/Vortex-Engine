part of vortex_engine;

abstract class Service {}

class KeyboardService extends Service {
  static final StreamController<KeyEvent> streamController =
      StreamController.broadcast();

  static Stream<KeyEvent> requestFor(Sprite sprite) {
    return streamController.stream;
  }
}
