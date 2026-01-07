import 'package:Monchaa/pages/main_pages.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void  main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFCADEFC),
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFCADEFC),
      foregroundColor: Colors.black87,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFCADEFC),
      foregroundColor: Colors.black87,
    ),
  ),
  home: const MainPage(),
);

  }
}

