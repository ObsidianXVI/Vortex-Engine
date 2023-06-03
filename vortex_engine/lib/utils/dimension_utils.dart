part of vortex_engine;

class ScreenDimensions {
  static double getHeight(BuildContext context) {
    final padding = MediaQuery.of(context).viewPadding;
    final height = MediaQuery.of(context).size.height;
    return height - padding.top;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
