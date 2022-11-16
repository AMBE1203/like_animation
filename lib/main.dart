import 'package:flutter/material.dart';

import 'like_animation_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LikeAnimationWidget(
      colorOfIcon: [
        Colors.red,
        Colors.yellow,
        Colors.blue,
        Colors.purpleAccent,
      ],
    );
  }
}
