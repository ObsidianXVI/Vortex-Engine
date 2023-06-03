library vortex_engine;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part './nav/views.dart';
part './core/vortex_canvas.dart';
part './sprites/sprite.dart';
part './sprites/spritesheet.dart';
part './sprites/sprite_image.dart';
part './layout/position.dart';
part './services/keyboard_service.dart';
part './utils/dimension_utils.dart';
part './utils/types.dart';

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
      debugShowCheckedModeBanner: false,
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
