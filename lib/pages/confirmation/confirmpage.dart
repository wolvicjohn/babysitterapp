import 'package:babysitterapp/pages/homepage/home_page.dart';
import 'package:babysitterapp/styles/colors.dart';
import 'package:babysitterapp/components/button.dart';
import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  final String babysitterName;
  final String specialRequirements;
  final String selectedTime;
  final String paymentTiming;
  final String paymentMode;

  const ConfirmationPage({
    super.key,
    required this.babysitterName,
    required this.specialRequirements,
    required this.selectedTime,
    required this.paymentTiming,
    required this.paymentMode,
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
            const Text(
              'Booking Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            Table(
              border: TableBorder.all(
                color: Colors.black12,
                width: 1,
                borderRadius: BorderRadius.circular(8.0),
              ),
              children: [
                _buildTableRow('Babysitter Name:', babysitterName),
                _buildTableRow('Special Requirements:', specialRequirements),
                _buildTableRow('Selected Time:', selectedTime),
                _buildTableRow('Payment Timing:', paymentTiming),
                _buildTableRow('Payment Mode:', paymentMode),
              ],
            ),

            const SizedBox(height: 30),

            // Updated Confirm Button using AppButton
            AppButton(
              text: 'Confirm',
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
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage()),
                                        );
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
            ),
            const SizedBox(height: 10),

            // Cancel Button
            AppButton(
              text: 'Cancel',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a table row with label and value
  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            overflow: TextOverflow
                .ellipsis, // Handles overflow if the text is too long
          ),
        ),
      ],
    );
  }
}
