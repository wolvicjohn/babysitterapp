import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BabySitterWelcomePage extends StatelessWidget {
  const BabySitterWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value) =>
                  {Navigator.pushReplacementNamed(context, '/login')});
            },
          )
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
