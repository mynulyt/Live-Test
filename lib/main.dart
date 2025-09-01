import 'package:flutter/material.dart';
import 'package:live_text/live_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Recipes',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RecipeListPage(),
    );
  }
}
