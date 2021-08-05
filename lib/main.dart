import 'package:flutter/material.dart';
import 'package:git_ihm/screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clever Git',
      theme: ThemeData.dark(),
      home: const HomeScreen(title: 'Clever Git'),
    );
  }
}
