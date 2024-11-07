import 'package:babysitterapp/components/textfield.dart';
import 'package:babysitterapp/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../confirmation/confirmpage.dart';

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
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  // New state to track selected days
  final Map<String, bool> _selectedDays = {
    'Monday': true,
    'Tuesday': true,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': false,
    'Sunday': false,
  };

  String get formattedDate => _selectedDate != null
      ? DateFormat.yMMMMd().format(_selectedDate!)
      : 'Select Date';

  String get formattedTime =>
      _selectedTime != null ? _selectedTime!.format(context) : 'Select Time';

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

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
        ),
      );
      return;
    }

    // Get selected days as a string
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
          date: formattedDate,
          time: formattedTime,
          specialRequirements: _specialRequirementsController.text,
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

            // Display the babysitter profile image
            Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.babysitterImage),
                  radius: 50,
                ),
                Text(
                  widget.babysitterName,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // booking form container
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
                  _buildPickerSection(
                    title: 'Select Date',
                    value: formattedDate,
                    icon: Icons.calendar_today,
                    onTap: _pickDate,
                  ),
                  const SizedBox(height: 16),
                  _buildPickerSection(
                    title: 'Select Time',
                    value: formattedTime,
                    icon: Icons.access_time,
                    onTap: _pickTime,
                  ),
                  const SizedBox(height: 16),
                  // Availability selector
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Available Days',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        ..._selectedDays.keys.map((day) {
                          // Only display days that are selected
                          return _selectedDays[day] == true
                              ? ListTile(
                                  leading: const Icon(Icons.check,
                                      color: Colors.green),
                                  title: Text(day,
                                      style:
                                          const TextStyle(color: Colors.black)),
                                )
                              : const SizedBox.shrink();
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                      hintText: 'Enter any special requirements',
                      controller: _specialRequirementsController),
                  // TextField(
                  //   controller: _specialRequirementsController,
                  //   decoration: InputDecoration(
                  //     labelText: 'Special Requirements',
                  //     hintText: 'Enter any special requirements',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8.0),
                  //     ),
                  //     filled: true,
                  //     fillColor: Theme.of(context).cardColor,
                  //   ),
                  //   maxLines: 3,
                  // ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _submitBooking,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
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
