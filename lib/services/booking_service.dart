import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to get bookings for the logged-in user
  Stream<QuerySnapshot> getUserBookings() {
    if (_auth.currentUser == null) {
      return const Stream.empty();
    }

    return _firestore
        .collection('bookings')
        .where('userEmail', isEqualTo: _auth.currentUser!.email)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Method to save booking details in Firestore
  Future<void> saveBooking({
    required String babysitterName,
    required String specialRequirements,
    required String duration,
    required String paymentMode,
    required String totalpayment,
    required double babysitterRate,
  }) async {
    try {
      // Get the current user's email
      User? user = _auth.currentUser;
      if (user == null) {
        print("No user is logged in.");
        return;
      }
      String userEmail = user.email!;

      // Save booking details to Firestore, including the user's email
      await _firestore.collection('bookings').add({
        'babysitterName': babysitterName,
        'specialRequirements': specialRequirements,
        'duration': duration,
        'paymentMode': paymentMode,
        'totalpayment': totalpayment,
        'babysitterRate': babysitterRate,
        'status': 'confirmed', // Assuming status is 'confirmed' when saved
        'createdAt': FieldValue
            .serverTimestamp(), // Timestamp of when the booking was created
        'userEmail': userEmail, // Store the user's email with the booking
      });

      print("Booking saved successfully.");
    } catch (e) {
      print("Failed to save booking: $e");
    }
  }
}
