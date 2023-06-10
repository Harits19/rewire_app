import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:init_flutter/ui/bottom_navigation/bottom_navigation_page.dart';

void main() async {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData.light().copyWith(
        cardTheme: CardTheme(shape: card),
        listTileTheme: ListTileThemeData(
          shape: card,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        cardTheme: CardTheme(shape: card),
        listTileTheme: ListTileThemeData(
          shape: card,
        ),
      ),
      home: const BottomNavigationPage(),
    );
  }
}
