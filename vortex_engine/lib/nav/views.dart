part of vortex_engine;

abstract class View extends Widget {
  final String slug;

  const View({required this.slug, super.key});
}

abstract class StatelessView extends View {
  const StatelessView({required super.slug, super.key});
}

abstract class StatefulView extends StatefulWidget {
  final String slug;
  const StatefulView({required this.slug, super.key});
}
