import 'package:babysitterapp/pages/chatboxpage.dart';
import 'package:babysitterapp/pages/chatpage.dart';
import 'package:babysitterapp/pages/home_page.dart';
import 'package:babysitterapp/pages/profilepage.dart';
import 'package:babysitterapp/styles/theme_data.dart';
import 'package:flutter/material.dart';

import 'pages/ratepage.dart';

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
        home: const ProfilePage(
          babysitterId: 'heymars',
        ));
  }
}
