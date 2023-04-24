import 'package:borardgame/screens/grid_screen.dart';
import 'package:borardgame/screens/select_grid_size.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '2048',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SelectGridSize(),
    );
  }
}
