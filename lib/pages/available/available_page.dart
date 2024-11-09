import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AvailabilityPage extends StatefulWidget {
  const AvailabilityPage({super.key});

  @override
  _AvailabilityPageState createState() => _AvailabilityPageState();
}

class _AvailabilityPageState extends State<AvailabilityPage> {
  final List<Map<String, String>> _availability =
      []; // List to store availability

  Future<void> _pickDateTime() async {
    // Pick date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate == null) return; // If no date is picked, return

    // Pick time
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null) return; // If no time is picked, return

    // Combine picked date and time
    final DateTime pickedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    // Format date and time for display
    final String formattedDate =
        DateFormat('MMMM dd, yyyy').format(pickedDateTime);
    final String formattedTime = DateFormat('hh:mm a').format(pickedDateTime);

    // Add single availability to list
    setState(() {
      _availability.add({
        'date': formattedDate,
        'time': formattedTime,
      });
    });
  }

  void _clearAvailability() {
    setState(() {
      _availability.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Schedule',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _clearAvailability,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Set Schedule:',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickDateTime,
              icon: const Icon(Icons.calendar_today, color: Colors.white),
              label: const Text(
                'Pick a schedule',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              'Your Availability:',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Display availability list
            _availability.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _availability.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          title: Text(
                            _availability[index]['date']!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Colors.deepPurple,
                            ),
                          ),
                          subtitle: Text(
                            _availability[index]['time']!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.black),
                            onPressed: () {
                              setState(() {
                                _availability.removeAt(index);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      'No availability set yet!',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
