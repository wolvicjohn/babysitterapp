import 'package:flutter/material.dart';

class TransactionNotificationCard extends StatelessWidget {
  final String name;
  final String time;
  final String duration;
  final String totalPayment;
  final String paymentStatus;
  final String paymentMode;

  const TransactionNotificationCard({
    super.key,
    required this.name,
    required this.time,
    required this.paymentStatus,
    required this.duration,
    required this.totalPayment,
    required this.paymentMode,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "You booked a transaction from:",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(paymentStatus).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    paymentStatus,
                    style: TextStyle(
                      color: _getStatusColor(paymentStatus),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$duration hours",
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                "Paid: P$totalPayment via $paymentMode",
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    time,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
