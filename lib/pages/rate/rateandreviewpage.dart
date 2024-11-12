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

  //store current user new message
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
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        //view image
                                        ListTile(
                                          leading: const Icon(
                                            Icons.remove_red_eye,
                                            color: primaryColor,
                                          ),
                                          title: const Text("View photo"),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                backgroundColor: primaryColor,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Image.file(
                                                      image,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text(
                                                        "Close",
                                                        style: TextStyle(
                                                          color: primaryFgColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        //remove image
                                        ListTile(
                                          leading: const Icon(
                                            Icons.delete,
                                            color: dangerColor,
                                          ),
                                          title: const Text("Remove photo"),
                                          onTap: () {
                                            setState(() {
                                              _images.removeAt(index);
                                              Navigator.of(context).pop();
                                            });
                                          },
                                        ),
                                      ],
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
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: const Icon(
                                          Icons.camera_alt,
                                          color: primaryColor,
                                        ),
                                        title: const Text("Take a photo"),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          _pickImage(ImageSource.camera);
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(
                                          Icons.photo,
                                          color: primaryColor,
                                        ),
                                        title:
                                            const Text("Choose from gallery"),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          _pickImage(ImageSource.gallery);
                                        },
                                      ),
                                    ],
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
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Submit review'),
                                content: const Text(
                                    'Are you sure to submit your review?'),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: backgroundColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: const BorderSide(
                                            color: primaryColor,
                                          ),
                                        )),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(color: textColor),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: const BorderSide(
                                            color: primaryColor,
                                          ),
                                        )),
                                    onPressed: () {
                                      if (_rating != 0) {
                                        Navigator.pop(context);

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
                                              child:
                                                  customWidget.thankYouDialog(
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
                                        //display confirmation modal
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Empty rating'),
                                              content: const Text(
                                                  'Please input rating.'),
                                              actions: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              backgroundColor,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            side:
                                                                const BorderSide(
                                                              color:
                                                                  primaryColor,
                                                            ),
                                                          )),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    'Close',
                                                    style: TextStyle(
                                                        color: textColor),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: const Text('Submit'),
                                  ),
                                ],
                              );
                            },
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
