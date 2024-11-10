import 'package:babysitterapp/pages/homepage/home_page.dart';

import '../../views/customwidget.dart';
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
                const SizedBox(height: 15),
                const Text(
                  'How was your experience with me?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        //add photo function
                      },
                      child: const Column(
                        children: [
                          Icon(
                            Icons.photo,
                            size: 70,
                          ),
                          Text(
                            'Add Photo',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //add video function
                      },
                      child: const Column(
                        children: [
                          Icon(
                            Icons.video_camera_back,
                            size: 70,
                          ),
                          Text(
                            'Add Video',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _feedbackController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please share any additional feedback.',
                  ),
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
                              //pop until landing page
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                              );
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
