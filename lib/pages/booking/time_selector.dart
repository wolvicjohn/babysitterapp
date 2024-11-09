import 'package:flutter/material.dart';
import '../../styles/colors.dart';

class TimeSelector extends StatefulWidget {
  final Function(String) onTimeSelected; // Callback to handle selected time

  const TimeSelector({super.key, required this.onTimeSelected});

  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  String _selectedTime = 'Morning'; // Default time

  @override
  Widget build(BuildContext context) {
    return Container(
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
            'Select Booking Time',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Radio<String>(
                value: 'Morning',
                groupValue: _selectedTime,
                onChanged: (String? value) {
                  setState(() {
                    _selectedTime = value!;
                    widget.onTimeSelected(_selectedTime); // Notify parent
                  });
                },
              ),
              const Text('6-11AM'),
              Radio<String>(
                value: 'Afternoon',
                groupValue: _selectedTime,
                onChanged: (String? value) {
                  setState(() {
                    _selectedTime = value!;
                    widget.onTimeSelected(_selectedTime); // Notify parent
                  });
                },
              ),
              const Text('12-5PM'),
              Radio<String>(
                value: 'Evening',
                groupValue: _selectedTime,
                onChanged: (String? value) {
                  setState(() {
                    _selectedTime = value!;
                    widget.onTimeSelected(_selectedTime); // Notify parent
                  });
                },
              ),
              const Text('6-12'),
            ],
          ),
        ],
      ),
    );
  }
}
