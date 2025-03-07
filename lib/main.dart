import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(const RecipeSuggesterApp());
}

class RecipeSuggesterApp extends StatelessWidget {
  const RecipeSuggesterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Suggester',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SplashScreen(),
    );
  }
}
