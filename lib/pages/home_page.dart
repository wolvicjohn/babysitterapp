import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Baby Sitter App"),
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/images/app-logo.png',
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
