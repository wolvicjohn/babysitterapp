import 'package:babysitterapp/components/button.dart';
import 'package:babysitterapp/styles/colors.dart';
import 'package:flutter/material.dart';

class RatePage extends StatefulWidget {
  const RatePage({super.key});

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  final TextEditingController _feedbackController = TextEditingController();
  int _rating = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Babysitter'),
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/female5.jpg'),
                  radius: 70,
                ),
                const SizedBox(height: 5),
                const Text(
                  'Donna Martin',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) {
                      return IconButton(
                        icon: Icon(
                          index < _rating ? Icons.star : Icons.star_border,
                          color: primaryColor,
                          size: 40,
                        ),
                        onPressed: () {
                          setState(() {
                            _rating = index + 1;
                          });
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Additional Comment',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _feedbackController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your comment',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                AppButton(
                  onPressed: () {
                    setState(() {
                      _rating = 0;
                    });
                  },
                  text: 'Submit',
                )
                // ElevatedButton(
                //   onPressed: () {
                //     setState(() {
                //       _rating = 0;
                //     });
                //   },
                //   style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.deepPurple),
                //   child: const Text('SUBMIT'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
