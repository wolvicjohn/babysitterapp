import '/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controller/babysitter.dart';
import '../controller/userdata.dart';
import '../view/aboutheader.dart';
import '../view/customwidget.dart';
import '../view/experienceheader.dart';
import '../view/feedbackheader.dart';
import '../view/mainheader.dart';
import 'chatboxpage.dart';

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

  @override
  void initState() {
    super.initState();
    babysitter = userData.babysitterList.firstWhere(
      (babysitter) => babysitter.id == widget.babysitterId,
    );

    var userRatingsList = userData.ratingAndReviewList
        .where((rating) => rating.id == widget.babysitterId)
        .toList();

    if (userRatingsList.isNotEmpty) {
      double averageRating =
          userRatingsList.map((r) => r.rating).reduce((a, b) => a + b) /
              userRatingsList.length;

      babysitterRating = double.parse(averageRating.toStringAsFixed(1));

      noOfReviews = userRatingsList.length;
    } else {
      babysitterRating = 0;
    }
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
            () {},
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
              MainHeader(
                img: babysitter.img,
                name: babysitter.name,
                email: babysitter.email,
                rating: babysitterRating,
                reviewsNo: noOfReviews,
                address:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                rate: 200,
              ),
              const Divider(
                color: Color.fromARGB(255, 216, 216, 216),
              ),
              AboutHeader(
                userFirstName: babysitter.name.split(' ')[0],
                userAbout:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus ac justo venenatis, sodales nisi ac, eleifend mi. Vestibulum nec augue porta, ultrices est in, posuere diam. In scelerisque id ante a placerat. Interdum et malesuada fames ac ante ipsum primis in faucibus. Suspendisse sagittis justo quis ante venenatis pretium. Etiam imperdiet lorem erat, sed mollis nulla aliquet in. Fusce gravida tempor ex at bibendum. Curabitur porttitor erat ac leo varius vestibulum. Vivamus dapibus massa est, vitae elementum nisl fringilla id. Nunc sit amet orci dui. Mauris convallis maximus ante, ac ullamcorper nibh iaculis vel. Cras pharetra scelerisque urna eleifend facilisis. Nullam in porttitor lorem. Nunc luctus vitae odio vel semper. Aliquam erat volutpat. Quisque sodales turpis quis accumsan mattis. Praesent bibendum risus eget enim aliquam vehicula sed nec odio. Fusce turpis augue, hendrerit sit amet vestibulum eget, dapibus eget diam. Suspendisse eget iaculis ante.',
              ),
              const Divider(
                color: Color.fromARGB(255, 216, 216, 216),
              ),
              ExperienceHeader(),
              const Divider(
                color: Color.fromARGB(255, 216, 216, 216),
              ),
              FeedbackHeader(
                babysitterId_: widget.babysitterId,
              ),
            ],
          );
        },
      ),
    );
  }
}
