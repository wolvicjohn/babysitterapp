import 'dart:io';

import 'package:babysitterapp/controller/feedback.dart';
import 'package:collection/collection.dart';
import 'package:image_picker/image_picker.dart';

import '/pages/homepage/home_page.dart';
import '/services/firestore.dart';
import '/controller/user.dart';
import '/views/customwidget.dart';
import '/components/button.dart';
import '/styles/colors.dart';
import 'package:flutter/material.dart';

class RateAndReviewPage extends StatefulWidget {
  final String babysitterID;
  final String currenUserID = 'sampleuser01';
  const RateAndReviewPage({super.key, required this.babysitterID});

  @override
  State<RateAndReviewPage> createState() => _RateAndReviewPageState();
}

class _RateAndReviewPageState extends State<RateAndReviewPage> {
  final FirestoreService firestoreService = FirestoreService();
  late User? babysitter;
  final CustomWidget customWidget = CustomWidget();
  final TextEditingController _feedbackController = TextEditingController();
  int _rating = 0;
  final List<File> _images = []; // List to store selected images
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    babysitter = null;
    fetchUserData();
    super.initState();
  }

  //fetch babysitter data based on babysitterID
  Future<void> fetchUserData() async {
    babysitter = await firestoreService.getUserData(widget.babysitterID);
    setState(() {});
  }

  // Function to pick an image from the gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    if (_images.length >= 4) return; // Limit to 4 images

    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  //store current user new feedback
  addFeedback(String? message, int rating, List<File>? images) async {
    FeedBack newFeedBack = FeedBack(
      id: widget.currenUserID,
      rating: rating,
      feedbackMsg: message,
      images: [
        'assets/images/male5.jpg',
        'assets/images/male4.jpg',
        'assets/images/male3.jpg',
        'assets/images/male2.jpg'
      ],
      timestamp: DateTime.now(),
    );

    // Add the new feedback to babysitter feedback collection
    await firestoreService.addFeedback(
        widget.currenUserID, widget.babysitterID, newFeedBack);

    setState(() {
      _rating = 0;
      _images.clear();
    });
    _feedbackController.clear();
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
      body: (babysitter != null)
          ? Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(babysitter!.img),
                        radius: 70,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        babysitter!.name,
                        style: const TextStyle(
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
                                index < _rating
                                    ? Icons.star
                                    : Icons.star_border,
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
                      const Text(
                        'Add Photo:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Wrap(
                        spacing: 8.0,
                        children: [
                          // Display selected images
                          ..._images.mapIndexed((index, image) => InkWell(
                                onTap: () {
                                  //choose between view or remove selected photo
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        customWidget.rateAndReviewbottomModal(
                                      const Icon(
                                        Icons.remove_red_eye,
                                        color: primaryColor,
                                      ),
                                      'View photo',
                                      () {
                                        Navigator.of(context).pop();
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              customWidget.showImageDialog(
                                            context,
                                            image,
                                          ),
                                        );
                                      },
                                      const Icon(
                                        Icons.delete,
                                        color: dangerColor,
                                      ),
                                      'Remove photo',
                                      () {
                                        setState(() {
                                          _images.removeAt(index);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    image,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                          // Add photo button
                          if (_images.length < 4)
                            InkWell(
                              onTap: () async {
                                //choose from camera or gallery
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      customWidget.rateAndReviewbottomModal(
                                    const Icon(
                                      Icons.camera_alt,
                                      color: primaryColor,
                                    ),
                                    'Take a photo',
                                    () {
                                      Navigator.of(context).pop();
                                      _pickImage(ImageSource.camera);
                                    },
                                    const Icon(
                                      Icons.photo,
                                      color: primaryColor,
                                    ),
                                    'Choose from gallery',
                                    () {
                                      Navigator.of(context).pop();
                                      _pickImage(ImageSource.gallery);
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 2),
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Icon(Icons.add, color: Colors.grey),
                                ),
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
                          //display confirmation modal
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) =>
                                customWidget.rateAndReviewAlertDialog(
                              'assets/images/confirm.gif',
                              'Are you sure to submit your review?',
                              [
                                customWidget.alertDialogBtn(
                                  'Cancel',
                                  backgroundColor,
                                  primaryColor,
                                  textColor,
                                  () {
                                    Navigator.pop(context);
                                  },
                                ),
                                customWidget.alertDialogBtn(
                                  'Submit',
                                  primaryColor,
                                  primaryColor,
                                  backgroundColor,
                                  () {
                                    if (_rating != 0) {
                                      Navigator.pop(context);

                                      //add feedback to firestore
                                      addFeedback(
                                        _feedbackController.text,
                                        _rating,
                                        _images,
                                      );

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
                                                      builder: (context) =>
                                                          const HomePage()),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      Navigator.pop(context);
                                      //display empty rating modal
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) =>
                                            customWidget
                                                .rateAndReviewAlertDialog(
                                          'assets/images/error.gif',
                                          'Please input rating.',
                                          [
                                            customWidget.alertDialogBtn(
                                              'Close',
                                              backgroundColor,
                                              primaryColor,
                                              textColor,
                                              () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        text: 'Submit',
                      )
                    ],
                  ),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
