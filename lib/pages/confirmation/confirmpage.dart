import 'package:flutter/material.dart';
import '../../styles/colors.dart';

class ConfirmationPage extends StatelessWidget {
  final String babysitterName;
  final String date;
  final String time;
  final String specialRequirements;

  const ConfirmationPage({
    Key? key,
    required this.babysitterName,
    required this.date,
    required this.time,
    required this.specialRequirements,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        centerTitle: true,
      ),
      backgroundColor: backgroundColor,
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
                color: textColor,
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
                columnWidths: const {0: FixedColumnWidth(150)},
                children: [
                  _buildTableRow('Babysitter Name:', babysitterName),
                  _buildTableRow('Date:', date),
                  _buildTableRow('Time:', time),
                  _buildTableRow('Special Requirements:', specialRequirements),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _confirmBooking(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: primaryFgColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text('Confirm'),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Center(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: secondaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Text(label,
            style:
                const TextStyle(fontWeight: FontWeight.bold, color: textColor)),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(value, style: const TextStyle(color: textColor)),
        ),
      ],
    );
  }

  void _confirmBooking(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: backgroundColor,
        title: const Text(
          'Confirm Booking',
          style: TextStyle(color: textColor),
        ),
        content: const Text(
          'Are you sure you want to confirm this booking?',
          style: TextStyle(color: textColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text('Cancel', style: TextStyle(color: secondaryColor)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showConfirmationDialog(context);
            },
            child: const Text('Confirm', style: TextStyle(color: primaryColor)),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: backgroundColor,
        title: const Text(
          'Booking Confirmed',
          style: TextStyle(color: textColor),
        ),
        content: const Text(
          'Your booking has been confirmed successfully!',
          style: TextStyle(color: textColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Center(
              child: Text('OK', style: TextStyle(color: primaryColor)),
            ),
          ),
        ],
      ),
    );
  }
}
