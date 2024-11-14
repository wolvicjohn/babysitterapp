//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'samplebabysitter01'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'samplebabysitter01'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'samplebabysitter01'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'samplebabysitter01'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'samplebabysitter01'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'samplebabysitter01'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'samplebabysitter01'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'samplebabysitter01'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'samplebabysitter01'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'samplebabysitter01'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'samplebabysitter01'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'samplebabysitter01'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'samplebabysitter01'

import 'package:babysitterapp/pages/booking/requestpage.dart';
import 'package:babysitterapp/pages/chat/chatboxpage.dart';
import 'package:babysitterapp/services/firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/feedback.dart';
import '../../views/customwidget.dart';
import '/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../controller/user.dart';
import '/controller/userdata.dart';

class BabysitterProfilePage extends StatefulWidget {
  final String babysitterID;
  const BabysitterProfilePage({
    super.key,
    required this.babysitterID,
  });

  @override
  State<BabysitterProfilePage> createState() => _BabysitterProfilePageState();
}

class _BabysitterProfilePageState extends State<BabysitterProfilePage> {
  final FirestoreService firestoreService = FirestoreService();
  final UserData userData = UserData();
  final CustomWidget customWidget = CustomWidget();
  late User? babysitter;
  late List<FeedBack>? feedbackList;
  late double babysitterRating;
  late int noOfReviews;
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    babysitter = null;
    feedbackList = [];
    babysitterRating = 0;
    noOfReviews = 0;
    isExpanded = false;
  }

  //fetch babysitter data based on babysitterID
  Future<void> fetchUserData() async {
    babysitter = await firestoreService.getUserData(widget.babysitterID);
    feedbackList = await firestoreService.getFeedbackList(widget.babysitterID);
    if (feedbackList != null && feedbackList!.isNotEmpty) {
      noOfReviews = feedbackList!.length;
      babysitterRating =
          (feedbackList!.fold(0, (sum, item) => sum + item.rating)) /
              feedbackList!.length;
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (babysitter != null)
        ? Scaffold(
            appBar: AppBar(
              title: Text(babysitter!.name),
              actions: [
                IconButton(
                  onPressed: () {
                    final Uri phoneUri =
                        Uri(scheme: 'tel', path: babysitter!.phone.toString());
                    launchUrl(phoneUri);
                  },
                  icon: const Icon(Icons.phone),
                ),
              ],
            ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //floating buttons at the bottom of the screen
                customWidget.floatingBtn(
                  () {
                    //navigate to chatbox page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChatBoxPage(recipientID: widget.babysitterID)));
                  },
                  backgroundColor,
                  primaryColor,
                  const Icon(
                    CupertinoIcons.chat_bubble_2,
                    color: primaryColor,
                  ),
                  'Message',
                  textColor,
                ),
                customWidget.floatingBtn(
                  () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => BookingRequestPage(
                                babysitterImage: babysitter!.img,
                                babysitterName: babysitter!.name,
                              )),
                    );
                  },
                  primaryColor,
                  primaryColor,
                  const Icon(
                    CupertinoIcons.chevron_right_2,
                    size: 15,
                  ),
                  'Book Babysitter',
                  primaryFgColor,
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customWidget.mainHeader(
                      babysitter!.name,
                      babysitter!.email,
                      babysitter!.img,
                      babysitter!.address,
                      babysitter!.birtdate,
                      babysitter!.gender,
                      babysitter!.rate,
                      babysitterRating,
                      noOfReviews,
                      102,
                    ),
                    customWidget.aboutHeader(
                      babysitter!.name.split(' ')[0],
                      babysitter!.description,
                      isExpanded,
                      () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                    ),
                    customWidget.myDivider(),
                    customWidget.experienceHeader(babysitter!.experience),
                    customWidget.myDivider(),
                    customWidget.feedbackHeader(
                        widget.babysitterID, feedbackList),
                  ],
                );
              },
            ),
          )
        : const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
