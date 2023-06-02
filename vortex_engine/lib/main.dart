import './vortex_engine.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  final Map<String, WidgetFn> routes = {
    '/home': (BuildContext context) {
      return Center(
        child: TextButton(
          onPressed: () => Navigator.pushNamed(context, '/game-1'),
          child: Container(
            width: 400,
            height: 400,
            color: Colors.red,
          ),
        ),
      );
    },
  };
  runApp(VortexGame(
    routes: routes,
    initialRoute: '/home',
  ));
}
