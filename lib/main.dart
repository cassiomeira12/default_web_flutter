import 'strings.dart';
import 'themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'screens/login/login.dart';

void main() {
  runApp(
    MyApp()
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      debugShowCheckedModeBanner: true,
      theme: lightTheme(),
      home: Login(),
    );
  }
}
