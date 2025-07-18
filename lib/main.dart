import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals_app/screens/categories.dart';

final theme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 131, 57, 0),
    foregroundColor: Colors.white,
  ),
  textTheme: GoogleFonts.latoTextTheme().apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const CategoriesScreen(),
    );
  }
}
