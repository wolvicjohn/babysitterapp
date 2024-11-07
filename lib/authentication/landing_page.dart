import 'package:babysitterapp/components/button.dart';
import 'package:flutter/material.dart';

class BabySitterLandingPage extends StatefulWidget {
  const BabySitterLandingPage({super.key});

  @override
  State<BabySitterLandingPage> createState() => _BabySitterLandingPageState();
}

class _BabySitterLandingPageState extends State<BabySitterLandingPage> {
  bool isLoginButtonPressed = false;
  bool isRegisterButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFB39DDB), Color(0xFF9575CD)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/app-logo.png'),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(height: 20),
            const Text(
              'Babysitter Booking App',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            // Login button
            SizedBox(
                width: 250,
                child: AppButton(
                  text: "Login",
                  onPressed: () {
                    setState(() {
                      isLoginButtonPressed = true;
                    });
                    Navigator.pushNamed(context, '/login').then((_) {
                      setState(() {
                        isLoginButtonPressed = false;
                      });
                    });
                  },
                )),
            const SizedBox(height: 20),
            // Register button
            SizedBox(
                width: 250,
                child: AppButton(
                  text: "Register",
                  onPressed: () {
                    setState(() {
                      isRegisterButtonPressed = true;
                    });
                    Navigator.pushNamed(context, '/register').then((_) {
                      setState(() {
                        isRegisterButtonPressed = false;
                      });
                    });
                  },
                )),
          ],
        ),
      ),
    );
  }
}
