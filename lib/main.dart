import 'package:flutter/material.dart';
import 'package:look_back/domain/presentation/app_theme.dart';
import 'package:look_back/domain/presentation/screen/initial/initial_screen.dart';

void main() {
  runApp(const LookBackApp());
}

class LookBackApp extends StatelessWidget {
  const LookBackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lookback',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const InitialScreen(),
    );
  }
}
