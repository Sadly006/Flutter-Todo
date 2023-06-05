import 'package:flutter/material.dart';
import 'package:flutter_todos/src/Config/theme_provider.dart';
import 'package:flutter_todos/src/app.dart';
import 'package:provider/provider.dart';

void main() {
  var isDarkTheme = false;
  return runApp(
    ChangeNotifierProvider<ThemeProvider>(
      child: const App(),
      create: (BuildContext context) {
        return ThemeProvider(isDarkTheme);
      },
    ),
  );
}
