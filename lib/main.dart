import 'dart:math';

import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  static final _random = Random();

  static MaterialColor _getRandomColor() =>
      Colors.primaries[_random.nextInt(Colors.primaries.length)];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Overview',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.light(primary: _getRandomColor())),
      home: const HomePage(),
    );
  }
}
