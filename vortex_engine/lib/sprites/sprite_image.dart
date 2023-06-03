part of vortex_engine;

class SpriteImage extends Image {
  const SpriteImage({
    required super.image,
    super.key,
  }) : super(fit: BoxFit.cover);
}
