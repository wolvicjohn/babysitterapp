import 'package:babysitterapp/pages/home_page.dart';
import 'package:babysitterapp/pages/AccountPage/account_page.dart';
import 'package:babysitterapp/pages/AvailablePage/available_page.dart';
import 'package:babysitterapp/pages/ParentView/parentviewaccount.dart';
import 'package:babysitterapp/pages/ParentView/babysitter.dart';
import 'package:babysitterapp/pages/PaymentPage/payment_page.dart';
import 'package:babysitterapp/pages/RequirementPage/requirement_page.dart';
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
      home: const AccountPage(),
    );
  }
}
