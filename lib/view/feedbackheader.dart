import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'customwidget.dart';

class FeedbackHeader extends StatelessWidget {
  final String babysitterId_;
  final CustomWidget customWidget = CustomWidget();

  FeedbackHeader({super.key, required this.babysitterId_});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              customWidget.carouselItem(
                'assets/images/male4.jpg',
                'William Smith',
                5,
                r'"I can tell how hard you’ve worked to be more collaborative during meetings. Yesterday, although you disagreed with David’s idea, you asked some good questions first. Your critiques are more powerful than they used to be. You’ve come a long way, and the team is better for it."',
              ),
              customWidget.carouselItem(
                'assets/images/female2.jpg',
                'Victoria	Bell',
                4,
                r'"Your ability to work across teams and departments is a strength not everyone has. I’m impressed with the way you’re working to dismantle silos. For example, when you drew the marketing team into our conversations, it sharpened our ideas and helped us meet goals faster. Keep up the good work."',
              ),
              customWidget.carouselItem(
                'assets/images/male5.jpg',
                'Michael Ince',
                5,
                r'"You put so much hard work into getting this client, and it really paid off. Thanks to your focus and determination in going the extra mile and managing all of the complexities of this project, we met our goals."',
              ),
              customWidget.carouselItem(
                'assets/images/female5.jpg',
                'Donna Martin',
                5,
                r'"Even though the outcome wasn’t what we wanted, I want to congratulate you on all of the hard work you put in over the past few weeks. If we apply that same effort to our next project, I believe we can win."',
              ),
              customWidget.carouselItem(
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
  }
}
