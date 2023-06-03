part of vortex_engine;

/// Extend this to create customised asset managers
abstract class AssetManager {
  final Map<String, SpriteImage> assetStore;

  const AssetManager({
    required this.assetStore,
  });

  Future<void> preloadImages(BuildContext context) async {
    for (SpriteImage spriteImage in assetStore.values) {
      await precacheImage(spriteImage.image, context);
    }
    return;
  }
}
