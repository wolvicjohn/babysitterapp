import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:babysitterapp/styles/colors.dart';

class ContactSupport extends StatelessWidget {
  const ContactSupport({super.key});

  //function to launch the email app
  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'babysitterapp@gmail.com',
    );

    try {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Could not launch email app: $e');
    }
  }

  //function to launch the phone dialer
  Future<void> _launchPhoneDialer() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: '+123456789',
    );

    try {
      await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Could not launch phone dialer: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Support',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          '• Phone: Customer support number',
          style: TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 8.0),
        GestureDetector(
          onTap: _launchPhoneDialer,
          child: const Text(
            "+123456789",
            style: TextStyle(fontSize: 16.0, color: primaryColor),
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          '• Email: Support email for inquiries',
          style: TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 8.0),
        GestureDetector(
          onTap: _launchEmail,
          child: const Text(
            'babysitterapp@gmail.com',
            style: TextStyle(fontSize: 16.0, color: primaryColor),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
