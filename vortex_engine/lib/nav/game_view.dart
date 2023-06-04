part of vortex_engine;

abstract class GameView extends StatelessWidget {
  final GameConfigs gameConfigs;

  const GameView({
    required this.gameConfigs,
    super.key,
  });
}
