part of vortex_engine;

class Position {
  // measured from top left corner of the screen
  double x;
  double y;

  Position(this.x, this.y);

  void translate(double dx, double dy) {
    x += dx;
    y += dy;
  }
}
