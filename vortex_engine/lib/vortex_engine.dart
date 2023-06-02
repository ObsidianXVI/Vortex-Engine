library vortex_engine;

import 'package:flutter/material.dart';

part './nav/views.dart';

typedef WidgetFn = Widget Function(BuildContext);

class VortexGame extends StatelessWidget {
  final String initialRoute;
  final Map<String, WidgetFn> routes;
  const VortexGame({
    required this.routes,
    required this.initialRoute,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VortexLaunchView(initialRoute: initialRoute),
      routes: routes,
    );
  }
}

class VortexLaunchView extends StatefulView {
  final String initialRoute;
  const VortexLaunchView({
    required this.initialRoute,
    super.key,
  }) : super(slug: '/launch');

  @override
  State<VortexLaunchView> createState() => VortexLaunchViewState();
}

class VortexLaunchViewState extends State<VortexLaunchView> {
  VortexLaunchViewState();

  @override
  void initState() {
    // change to StreamListener with event game.onReady
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushNamed(context, widget.initialRoute);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: Text('Vortex is launching...'),
      ),
    );
  }
}
