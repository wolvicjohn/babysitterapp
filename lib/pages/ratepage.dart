import '/view/customwidget.dart';
import '/components/button.dart';
import '/styles/colors.dart';
import 'package:flutter/material.dart';

class RatePage extends StatefulWidget {
  const RatePage({super.key});

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  CustomWidget customWidget = CustomWidget();
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
          margin: const EdgeInsets.symmetric(horizontal: 40),
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
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'How was your experience with me',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Please share any additional feedback',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
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
                    //display thankyou modal
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Center(
                          child: customWidget.thankYouDialog(
                            () {
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                            },
                          ),
                        );
                      },
                    );
                    setState(() {
                      _rating = 0;
                    });
                    _feedbackController.clear();
                  },
                  text: 'Submit',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
