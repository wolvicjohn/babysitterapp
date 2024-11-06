import 'package:babysitterapp/pages/location/babysitter_view_location.dart';
import 'package:babysitterapp/pages/search_page/search_page.dart';
import 'package:babysitterapp/pages/settings_page/settings_page.dart';
import 'package:babysitterapp/styles/theme_data.dart';
import 'package:flutter/material.dart';

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
        home: const BabysitterViewLocation());
  }
}
