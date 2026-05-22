import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/terminal/terminal_screen.dart';

void main() {
  runApp(const ShadowNetApp());
}

class ShadowNetApp extends StatelessWidget {
  const ShadowNetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const TerminalScreen(),
    );
  }
}