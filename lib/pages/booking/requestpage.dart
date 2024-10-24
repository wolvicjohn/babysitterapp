import 'package:babysitterapp/components/button.dart';
import 'package:babysitterapp/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../confirmation/confirmpage.dart';

class BookingRequestPage extends StatefulWidget {
  const BookingRequestPage({super.key});

  @override
  _BookingRequestPageState createState() => _BookingRequestPageState();
}

class _BookingRequestPageState extends State<BookingRequestPage> {
  final TextEditingController _specialRequirementsController =
      TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  // Format the selected date
  String get formattedDate => _selectedDate != null
      ? DateFormat.yMMMMd().format(_selectedDate!)
      : 'Select Date';

  // Format the selected time
  String get formattedTime =>
      _selectedTime != null ? _selectedTime!.format(context) : 'Select Time';

  // Open the date picker
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Open the time picker
  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // Handle booking submission
  void _submitBooking() {
    if (_selectedDate == null || _selectedTime == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Missing Information'),
          content: const Text('Please select both a date and time.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
          icon: const SizedBox(height: 20),
        ),
      );
      return;
    }

    // Navigate to ConfirmationPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmationPage(
          babysitterName: 'Carlo Velvestre',
          date: formattedDate,
          time: formattedTime,
          specialRequirements: _specialRequirementsController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Booking'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/form.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),

              // Booking Form
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
                  children: [
                    // Date Picker Section
                    _buildPickerSection(
                      title: 'Select Date',
                      value: formattedDate,
                      icon: Icons.calendar_today,
                      onTap: _pickDate,
                    ),

                    const SizedBox(height: 16),

                    // Time Picker Section
                    _buildPickerSection(
                      title: 'Select Time',
                      value: formattedTime,
                      icon: Icons.access_time,
                      onTap: _pickTime,
                    ),

                    const SizedBox(height: 16),

                    // Special Requirements Section
                    AppTextField(
                      controller: _specialRequirementsController,
                      hintText: 'Enter any special requirements',
                    ),

                    const SizedBox(height: 24),

                    // Submit Button
                    AppButton(
                      onPressed: _submitBooking,
                      text: 'Submit',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPickerSection({
    required String title,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
        trailing: Icon(icon),
        onTap: onTap,
      ),
    );
  }
}
