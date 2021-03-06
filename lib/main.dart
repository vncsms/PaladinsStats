import 'package:flutter/material.dart';
import 'package:paladins_stats_app/screens/mainScreen.dart';
import 'package:paladins_stats_app/screens/transferencia/lista.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: MainPage(),
      ),
    );
  }
}
