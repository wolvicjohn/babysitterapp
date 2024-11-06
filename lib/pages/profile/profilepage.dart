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
// BABYSITTER PROFILE

import '../../views/customwidget.dart';
import '../booking/requestpage.dart';
import '/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/controller/babysitter.dart';
import '/controller/userdata.dart';
import '../chat/chatboxpage.dart';

class ProfilePage extends StatefulWidget {
  final String babysitterId;

  const ProfilePage({
    super.key,
    required this.babysitterId,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserData userData = UserData();
  CustomWidget customWidget = CustomWidget();
  late Babysitter babysitter;
  late double babysitterRating;
  late int noOfReviews;
  late bool isExpanded;

  @override
  void initState() {
    super.initState();

    //fetch babysitter data based on babysitterID
    babysitter = userData.babysitterList.firstWhere(
      (babysitter) => babysitter.id == widget.babysitterId,
    );

    //fetch no. of babysitter feedback
    var babysitterRatingsList = userData.ratingAndReviewList
        .where((rating) => rating.id == widget.babysitterId)
        .toList();

    if (babysitterRatingsList.isNotEmpty) {
      double averageRating =
          babysitterRatingsList.map((r) => r.rating).reduce((a, b) => a + b) /
              babysitterRatingsList.length;

      babysitterRating = double.parse(averageRating.toStringAsFixed(1));

      noOfReviews = babysitterRatingsList.length;
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
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //floating buttons at the bottom of the screen
          customWidget.floatingBtn(
            context,
            () {
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingRequestPage(
                    babysitterImage: babysitter.img,
                    babysitterName: babysitter.name,
                  ),
                ),
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
              const Divider(
                color: Color.fromARGB(255, 216, 216, 216),
              ),
              customWidget.mainHeader(
                babysitter.img,
                babysitter.name,
                babysitter.email,
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                babysitterRating,
                200,
                noOfReviews,
              ),
              customWidget.myDivider(),
              customWidget.aboutHeader(
                babysitter.name.split(' ')[0],
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus ac justo venenatis, sodales nisi ac, eleifend mi. Vestibulum nec augue porta, ultrices est in, posuere diam. In scelerisque id ante a placerat. Interdum et malesuada fames ac ante ipsum primis in faucibus. Suspendisse sagittis justo quis ante venenatis pretium. Etiam imperdiet lorem erat, sed mollis nulla aliquet in. Fusce gravida tempor ex at bibendum. Curabitur porttitor erat ac leo varius vestibulum. Vivamus dapibus massa est, vitae elementum nisl fringilla id. Nunc sit amet orci dui. Mauris convallis maximus ante, ac ullamcorper nibh iaculis vel. Cras pharetra scelerisque urna eleifend facilisis. Nullam in porttitor lorem. Nunc luctus vitae odio vel semper. Aliquam erat volutpat. Quisque sodales turpis quis accumsan mattis. Praesent bibendum risus eget enim aliquam vehicula sed nec odio. Fusce turpis augue, hendrerit sit amet vestibulum eget, dapibus eget diam. Suspendisse eget iaculis ante.',
                isExpanded,
                () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
              customWidget.myDivider(),
              customWidget.experienceHeader(),
              customWidget.myDivider(),
              customWidget.feedbackHeader(widget.babysitterId),
            ],
          );
        },
      ),
    );
  }
}
