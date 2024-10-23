import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionInfoPage extends StatelessWidget {
  final String babysitterName;
  final String transactionId;
  final DateTime bookingDate;

  const TransactionInfoPage({
    super.key,
    required this.babysitterName,
    required this.transactionId,
    required this.bookingDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: $babysitterName',
                  style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              Text('Transaction Number: $transactionId',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text(
                  'Booking Date: ${DateFormat('yyyy-MM-dd').format(bookingDate)}',
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
