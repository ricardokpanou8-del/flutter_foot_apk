import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const FootballQuizApp());
}

class FootballQuizApp extends StatelessWidget {
  const FootballQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A1628),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E676),
          secondary: Color(0xFFFFD600),
          surface: Color(0xFF0A1628),
        ),
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}