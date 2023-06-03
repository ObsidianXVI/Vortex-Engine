part of vortex_engine;

class VortexCanvas extends StatefulWidget {
  final Image? fixedBackground;
  final Color bgColor;
  final Sprite activeSprite;
  final List<SpriteSheet> spriteSheets;
  final KeyboardService keyboardService = KeyboardService();

  VortexCanvas({
    required this.bgColor,
    required this.activeSprite,
    this.spriteSheets = const [],
    this.fixedBackground,
    super.key,
  });
  @override
  State<StatefulWidget> createState() => VortexCanvasState();
}

class VortexCanvasState extends State<VortexCanvas> {
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: KeyboardListener(
        autofocus: true,
        focusNode: focusNode,
        onKeyEvent: (keyEvent) =>
            KeyboardService.streamController.add(keyEvent),
        child: Container(
          width: ScreenDimensions.getWidth(context),
          height: ScreenDimensions.getHeight(context),
          color: widget.bgColor,
          child: Stack(
            children: [
              if (widget.fixedBackground != null)
                Positioned.fill(
                  child: widget.fixedBackground!,
                ),
              for (SpriteSheet sheet in widget.spriteSheets)
                Stack(
                  children: sheet.sprites,
                )
            ],
          ),
        ),
      ),
    );
  }
}
