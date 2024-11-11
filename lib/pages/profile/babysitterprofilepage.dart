//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'helloworld'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'helloworld'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'helloworld'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'helloworld'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'helloworld'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'helloworld'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'helloworld'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'helloworld'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'helloworld'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'helloworld'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'helloworld'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'helloworld'
//NOTE: If you want to navigate to this page, it requires babysitter ID. Just put a temporary ID 'helloworld'

import 'package:babysitterapp/controller/rating.dart';
import 'package:babysitterapp/pages/booking/requestpage.dart';
import 'package:babysitterapp/pages/chat/chatboxpage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../views/customwidget.dart';
import '/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/controller/babysitter.dart';
import '/controller/userdata.dart';

class BabysitterProfilePage extends StatefulWidget {
  final String babysitterId;
  const BabysitterProfilePage({
    super.key,
    required this.babysitterId,
  });

  @override
  State<BabysitterProfilePage> createState() => _BabysitterProfilePageState();
}

class _BabysitterProfilePageState extends State<BabysitterProfilePage> {
  UserData userData = UserData();
  CustomWidget customWidget = CustomWidget();
  late Babysitter babysitter;
  late List<Rating> babysitterReviewList;
  late double babysitterRating;
  late int noOfReviews;
  late bool isExpanded;

  @override
  void initState() {
    super.initState();

    //fetch babysitter data based on babysitterID
    babysitter = userData.babysitterList.firstWhere(
      (babysitter) => babysitter.babysitterID == widget.babysitterId,
    );

    //fetch no. of babysitter feedback
    babysitterReviewList = userData.ratingAndReviewList
        .where((rating) => rating.babysitterID == widget.babysitterId)
        .toList();

    if (babysitterReviewList.isNotEmpty) {
      double averageRating =
          babysitterReviewList.map((r) => r.rating).reduce((a, b) => a + b) /
              babysitterReviewList.length;

      babysitterRating = double.parse(averageRating.toStringAsFixed(1));

      noOfReviews = babysitterReviewList.length;
    } else {
      babysitterRating = 0;
      noOfReviews = 0;
    }

    isExpanded = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(babysitter.name),
        actions: [
          IconButton(
            onPressed: () {
              final Uri phoneUri = Uri(scheme: 'tel', path: babysitter.phone);
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
            context,
            () {
              //navigate to chatbox page
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChatBoxPage(babysitterId_: widget.babysitterId)));
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
            context,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => BookingRequestPage(
                          babysitterImage: babysitter.img,
                          babysitterName: babysitter.name,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customWidget.mainHeader(
                babysitter.name,
                babysitter.email,
                babysitter.img,
                babysitter.address,
                babysitter.birtdate,
                babysitter.gender,
                babysitter.rate,
                babysitterRating,
                noOfReviews,
                102,
              ),
              customWidget.aboutHeader(
                babysitter.name.split(' ')[0],
                babysitter.description,
                isExpanded,
                () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
              customWidget.myDivider(),
              customWidget.experienceHeader(babysitter.experience),
              customWidget.myDivider(),
              customWidget.feedbackHeader(
                  widget.babysitterId, babysitterReviewList),
            ],
          );
        },
      ),
    );
  }
}
