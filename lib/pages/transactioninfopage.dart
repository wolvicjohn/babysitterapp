import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../styles/colors.dart'; // Import your color definitions

class TransactionInfoPage extends StatelessWidget {
  final String babysitterName;
  final String transactionId;
  final DateTime bookingDate;

  const TransactionInfoPage({
    Key? key,
    required this.babysitterName,
    required this.transactionId,
    required this.bookingDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Success Icon and Title
                    Icon(Icons.check_circle, color: accentColor, size: 60),
                    const SizedBox(height: 10),
                    Text(
                      'Transaction Successful',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                    ),
                    const SizedBox(height: 20),

                    // Transaction Details
                    _detailRow('Babysitter:', babysitterName, context),
                    const SizedBox(height: 10),
                    _detailRow(
                      'Booking Date:',
                      DateFormat('yyyy-MM-dd').format(bookingDate),
                      context,
                    ),
                    const SizedBox(height: 30),

                    // Divider
                    Divider(color: Colors.grey[300]),

                    // Reference Number and Close Button
                    const SizedBox(height: 10),
                    Text(
                      'Reference No: ${transactionId.substring(0, 8)}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                    ),
                    const SizedBox(height: 20),

                    // Centered Close Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: primaryFgColor,
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'Close',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
    );
  }

  // Helper method to create a row of transaction details
  Widget _detailRow(String label, String value, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                ),
          ),
        ),
      ],
    );
  }
}
