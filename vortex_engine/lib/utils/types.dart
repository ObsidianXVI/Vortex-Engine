part of vortex_engine;

class Loop<T> {
  final List<T> list;
  int currentIndex = 0;

  Loop(this.list);

  T current() => list[currentIndex];

  void next() {
    if (currentIndex + 1 == list.length) {
      currentIndex = 0;
    } else {
      currentIndex += 1;
    }
  }
}
