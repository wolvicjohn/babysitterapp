import 'package:babysitterapp/components/button.dart';
import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  final String babysitterName;
  final String date;
  final String time;
  final String specialRequirements;

  const ConfirmationPage({
    super.key,
    required this.babysitterName,
    required this.date,
    required this.time,
    required this.specialRequirements,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Center(
              child: Image.asset(
                'assets/images/confirm.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Booking Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Table(
                columnWidths: const {
                  0: FixedColumnWidth(150),
                },
                children: [
                  TableRow(
                    children: [
                      const Text('Babysitter Name:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0), // Add top padding for space
                        child: Text(babysitterName),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text('Date:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0), // Add top padding for space
                        child: Text(date),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text('Time:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0), // Add top padding for space
                        child: Text(time),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text('Special Requirements:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0), // Add top padding for space
                        child: Text(specialRequirements),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: AppButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Booking'),
                        content: const Text(
                            'Are you sure you want to confirm this booking?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Booking Confirmed'),
                                    content: const Text(
                                        'Your booking has been confirmed successfully!'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Center(
                                          child: Text('OK'),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text('Confirm'),
                          ),
                        ],
                      );
                    },
                  );
                },
                text: 'Confirm',
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Center(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
