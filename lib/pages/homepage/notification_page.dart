import 'package:babysitterapp/components/transaction_notif_card.dart';
import 'package:babysitterapp/services/booking_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingService bookingService = BookingService();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: bookingService.getUserBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('An error occurred: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No notifications found.'));
          }

          final bookings = snapshot.data!.docs;

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index].data() as Map<String, dynamic>;

              return TransactionNotificationCard(
                name: booking['babysitterName'] ?? 'Unknown User',
                time: booking['createdAt'] != null
                    ? timeago
                        .format((booking['createdAt'] as Timestamp).toDate())
                    : 'Unknown Time',
                duration: booking['duration'] ?? 'Not specified',
                totalPayment: booking['totalpayment'] ?? 'No amount',
                paymentStatus: booking['status'] ?? 'Unknown',
                paymentMode: booking['paymentMode'] ?? 'Unknown',
              );
            },
          );
        },
      ),
    );
  }
}
