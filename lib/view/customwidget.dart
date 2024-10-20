import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../styles/colors.dart';

//temporary experience list
final List userExperience = [
  'Experience 1',
  'Experience 2',
  'Experience 3',
  'Experience 4',
  'Experience 5',
];

//floating button for profile page
class CustomWidget {
  Widget floatingBtn(
    context,
    Function() onPressed,
    Color backgroundColor,
    Color borderColor,
    Icon icon,
    String label,
    Color txtColor,
  ) =>
      ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromWidth(180),
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: borderColor,
              ),
            )),
        icon: icon,
        label: Text(
          label,
          style: TextStyle(color: txtColor),
        ),
      );

//carousel item for feedback header
  carouselItem(String img, String name, int rating, String feedback) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(img),
            radius: 40,
          ),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),
          ratingStar(rating, 30),
          const SizedBox(height: 15),
          SelectableText(
            feedback,
            textAlign: TextAlign.center,
          )
        ],
      );

  //divider for profile page
  Widget myDivider() => const Divider(
        color: Color.fromARGB(255, 216, 216, 216),
      );

  //main header for profile page
  Widget mainHeader(
    String img,
    String name,
    String email,
    String address,
    double rating,
    int rate,
    int reviewsNo,
  ) =>
      Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(img),
                  radius: 70,
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        ratingStar(rating.toInt(), 30),
                        Text(rating.toString()),
                      ],
                    ),
                    Text(
                      '$reviewsNo reviews',
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('26 Families Served')
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(email),
                Text(address),
                Text('\$$rate per hour for 1 child'),
              ],
            ),
          ],
        ),
      );

  //about header for profile page
  Widget aboutHeader(
    String userFirstName,
    String userAbout,
    bool isExpanded,
    Function() onPressed,
  ) =>
      Container(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About $userFirstName',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                userAbout,
                textAlign: TextAlign.justify,
                maxLines: isExpanded ? null : 5,
                overflow:
                    isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: onPressed,
                    icon: (isExpanded)
                        ? const Icon(CupertinoIcons.chevron_up)
                        : const Icon(CupertinoIcons.chevron_down),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  //experience header for profile page
  Widget experienceHeader() => Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Experience',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Column(
              children: userExperience.map((experience) {
                return Row(
                  children: [
                    const Icon(CupertinoIcons.checkmark_alt),
                    const SizedBox(width: 5),
                    Text(experience),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      );
  //feedback header for profile page
  Widget feedbackHeader(String babysitterId_) => Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 60),
        child: Column(
          children: [
            const Text(
              'Feedback',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            CarouselSlider(
              items: [
                carouselItem(
                  'assets/images/male4.jpg',
                  'William Smith',
                  5,
                  r'"I can tell how hard you’ve worked to be more collaborative during meetings. Yesterday, although you disagreed with David’s idea, you asked some good questions first. Your critiques are more powerful than they used to be. You’ve come a long way, and the team is better for it."',
                ),
                carouselItem(
                  'assets/images/female2.jpg',
                  'Victoria	Bell',
                  4,
                  r'"Your ability to work across teams and departments is a strength not everyone has. I’m impressed with the way you’re working to dismantle silos. For example, when you drew the marketing team into our conversations, it sharpened our ideas and helped us meet goals faster. Keep up the good work."',
                ),
                carouselItem(
                  'assets/images/male5.jpg',
                  'Michael Ince',
                  5,
                  r'"You put so much hard work into getting this client, and it really paid off. Thanks to your focus and determination in going the extra mile and managing all of the complexities of this project, we met our goals."',
                ),
                carouselItem(
                  'assets/images/female5.jpg',
                  'Donna Martin',
                  5,
                  r'"Even though the outcome wasn’t what we wanted, I want to congratulate you on all of the hard work you put in over the past few weeks. If we apply that same effort to our next project, I believe we can win."',
                ),
                carouselItem(
                  'assets/images/male3.jpg',
                  'Stephen Harris',
                  4,
                  r'"I really appreciated how you used check-ins to keep me up to date on your project this week. It helped me coordinate with our stakeholders, and I’m excited to share that we’re on track to launch. It’s also great to see your process. I’m impressed with the efficiencies you’re learning."',
                ),
              ],
              options: CarouselOptions(
                viewportFraction: .9,
                height: 400,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('See all reviews'),
            )
          ],
        ),
      );

  Widget ratingStar(i, double size_) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int x = 0; x < i; x++)
            Icon(
              Icons.star,
              color: primaryColor,
              size: size_,
            ),
          for (int y = 0; y < 5 - i; y++)
            Icon(
              Icons.star,
              color: Colors.grey,
              size: size_,
            ),
        ],
      );

  //Modal after submitting feedback
  Widget thankYouDialog(Function() onPressed) => SizedBox(
        height: 400,
        child: AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/success.gif'),
              const Text(
                'Thank You!',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const Text(
                'Your review helps us maintain a high-quality babysitting experience.',
                textAlign: TextAlign.center,
              )
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: onPressed,
              child: const Text('Ok'),
            ),
          ],
        ),
      );
}
