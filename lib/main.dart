import 'package:babysitterapp/pages/home_page.dart';
import 'package:babysitterapp/styles/theme_data.dart';
import 'package:flutter/material.dart';

import 'pages/booking request/requestpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Baby Sitter App',
        theme: ThemeClass.theme,
        home: MyHomePage());
  }
}
