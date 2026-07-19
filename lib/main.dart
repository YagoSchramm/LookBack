import 'package:flutter/material.dart';
import 'package:look_back/app_state.dart';
import 'package:look_back/domain/presentation/app_theme.dart';
import 'package:look_back/domain/presentation/screen/navigate_page/navigate_page_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppState()..loadTheme()),
    ],
    child: const LookBackApp()));
}

class LookBackApp extends StatelessWidget {
  const LookBackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) {
        return MaterialApp(
      title: 'Lookback',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: state.themeMode,
      home: const NavigatePageScreen(),
    );
      },
    );
  }
}
