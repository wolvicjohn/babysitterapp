import 'package:flutter/material.dart';
import '../../components/button.dart';
import '../../components/textfield.dart';
import '../../styles/colors.dart';
import '../confirmation/confirmpage.dart';
import 'availability.dart';
import 'time_selector.dart';

class BookingRequestPage extends StatefulWidget {
  final String babysitterImage;
  final String babysitterName;

  const BookingRequestPage({
    super.key,
    required this.babysitterImage,
    required this.babysitterName,
  });

  @override
  _BookingRequestPageState createState() => _BookingRequestPageState();
}

class _BookingRequestPageState extends State<BookingRequestPage> {
  final TextEditingController _specialRequirementsController =
      TextEditingController();
  final Map<String, bool> _selectedDays = {
    'Monday': true,
    'Tuesday': true,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': false,
    'Sunday': false,
  };

  // New field for selected time
  String? _selectedTime = 'Morning'; // Default time

  String? _paymentTiming = 'Before Service'; // Default to 'Before Service'
  String? _paymentMode = 'GCash'; // Default payment mode

  void _submitBooking() {
    String selectedDaysString = _selectedDays.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .join(', ');

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ConfirmationPage(
          babysitterName: widget.babysitterName,
          specialRequirements: _specialRequirementsController.text,
          selectedTime: _selectedTime ?? 'Morning',
          paymentTiming: _paymentTiming ?? 'Before Service',
          paymentMode: _paymentMode ?? 'GCash',
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  // Callback to handle selected time
  void _onTimeSelected(String selectedTime) {
    setState(() {
      _selectedTime = selectedTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Booking'),
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(color: Color(0xFFD8D8D8)),
            const SizedBox(height: 20),
            Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(widget.babysitterImage),
                  radius: 50,
                ),
                const SizedBox(height: 16),
                Text(
                  widget.babysitterName,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Babysitter details container
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
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
              child: const Column(
                children: [
                  Text(
                    'Babysitter Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 8),
                      Text('Location: Davao City'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.payment),
                      SizedBox(width: 8),
                      Text('Pay per Hour: Php 200'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.accessibility),
                      SizedBox(width: 8),
                      Text('Gender: Female'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today),
                      SizedBox(width: 8),
                      Text('Age: 28'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Availability and other selections
            Container(
              margin: const EdgeInsetsDirectional.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
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
              child: Column(
                children: [
                  AvailabilitySelector(selectedDays: _selectedDays),
                  const SizedBox(height: 16),
                  TimeSelector(onTimeSelected: _onTimeSelected),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Choose Payment Timing',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Before Service',
                              groupValue: _paymentTiming,
                              onChanged: (String? value) {
                                setState(() {
                                  _paymentTiming = value;
                                });
                              },
                            ),
                            const Text('Before'),
                            Radio<String>(
                              value: 'After Service',
                              groupValue: _paymentTiming,
                              onChanged: (String? value) {
                                setState(() {
                                  _paymentTiming = value;
                                });
                              },
                            ),
                            const Text('After'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Payment Mode',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'GCash',
                              groupValue: _paymentMode,
                              onChanged: (String? value) {
                                setState(() {
                                  _paymentMode = value;
                                });
                              },
                            ),
                            const Text('GCash'),
                            Radio<String>(
                              value: 'Card',
                              groupValue: _paymentMode,
                              onChanged: (String? value) {
                                setState(() {
                                  _paymentMode = value;
                                });
                              },
                            ),
                            const Text('Card'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _specialRequirementsController,
                    hintText: 'Enter any special requirements',
                    suffix: null,
                  ),
                  const SizedBox(height: 30),
                  AppButton(
                    text: 'Submit Request',
                    onPressed: _submitBooking,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
