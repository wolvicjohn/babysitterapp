import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String name;
  final String time;
  final int reviews;
  final String paymentStatus;

  const NotificationCard({
    super.key,
    required this.name,
    required this.time,
    required this.reviews,
    required this.paymentStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: Theme.of(context).textTheme.bodyLarge),
            Text(time, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            const Row(
              children: [
                Spacer(),
              ],
            ),
            const SizedBox(height: 8),
            Text('Reviews: $reviews',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Payment Status: $paymentStatus',
                  style: TextStyle(
                    color: paymentStatus == 'Paid' ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Icon(
                  paymentStatus == 'Paid' ? Icons.check_circle : Icons.cancel,
                  color: paymentStatus == 'Paid' ? Colors.green : Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
