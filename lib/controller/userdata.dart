//NOTE: This is temporary user data

import 'package:babysitterapp/controller/messages.dart';
import 'package:babysitterapp/views/customwidget.dart';

import 'currentuser.dart';

class UserData {
  CurrentUser currentUser = CurrentUser(
    name: 'Sebastian Abraham',
    email: 'sebastianabraham@gmail.com',
    id: 'user01',
    img: 'assets/images/male1.jpg',
    messages: [
      ListWithID(
        id: 'babysitter01',
        data: [
          Messages(
            id: 'user01',
            msg: 'Hi!',
            timestamp: DateTime(2024, 11, 10, 10, 30),
            isClicked: false,
          ),
          Messages(
            id: 'babysitter01',
            msg: 'Hello!',
            timestamp: DateTime(2024, 11, 10, 10, 32),
            isClicked: false,
          ),
          Messages(
            id: 'user01',
            msg: 'What is your name?',
            timestamp: DateTime(2024, 11, 10, 10, 34),
            isClicked: false,
          ),
          Messages(
            id: 'babysitter01',
            msg: 'Emma	Gill',
            timestamp: DateTime(2024, 11, 10, 10, 38),
            isClicked: false,
          ),
          Messages(
            id: 'user01',
            msg: 'Can you send me your picture?',
            timestamp: DateTime(2024, 11, 10, 10, 40),
            isClicked: false,
          ),
          Messages(
            id: 'babysitter01',
            msg: 'Sure!',
            timestamp: DateTime(2024, 11, 10, 10, 42),
            isClicked: false,
          ),
          Messages(
            id: 'babysitter01',
            msg: 'assets/images/female1.jpg',
            timestamp: DateTime(2024, 11, 10, 10, 44),
            isClicked: false,
          ),
        ],
      ),
      ListWithID(
        id: 'babysitter02',
        data: [
          Messages(
            id: 'user01',
            msg: 'Hey!',
            timestamp: DateTime(2024, 11, 10, 10, 30),
            isClicked: false,
          ),
          Messages(
            id: 'babysitter02',
            msg: 'Hello!',
            timestamp: DateTime(2024, 11, 10, 10, 32),
            isClicked: false,
          ),
          Messages(
            id: 'user01',
            msg: 'What is your name?',
            timestamp: DateTime(2024, 11, 10, 10, 34),
            isClicked: false,
          ),
          Messages(
            id: 'babysitter02',
            msg: 'Anthony Parr',
            timestamp: DateTime(2024, 11, 10, 10, 36),
            isClicked: false,
          ),
          Messages(
            id: 'user01',
            msg: 'Can you send me your picture?',
            timestamp: DateTime(2024, 11, 10, 13, 30),
            isClicked: false,
          ),
          Messages(
            id: 'babysitter02',
            msg: 'Sure!',
            timestamp: DateTime(2024, 11, 11, 14, 30),
            isClicked: false,
          ),
          Messages(
            id: 'babysitter02',
            msg: 'assets/images/male2.jpg',
            timestamp: DateTime(2024, 11, 11, 15, 30),
            isClicked: false,
          ),
          Messages(
            id: 'babysitter02',
            msg: 'yow!',
            timestamp: DateTime(2024, 10, 13, 15, 30),
            isClicked: false,
          ),
        ],
      ),
    ],
  );

  // List<Babysitter> babysitterList = [
  //   Babysitter(
  //     babysitterID: 'babysitter01',
  //     name: 'Emma Gill',
  //     email: 'emmagill@gmail.com',
  //     img: 'assets/images/female1.jpg',
  //     address: 'Panabo City',
  //     phone: '+639123456789',
  //     birtdate: DateTime(2000, 01, 01),
  //     gender: 'Female',
  //     rate: 100,
  //     description:
  //         """Hello! My name is Emma, and I'm a caring, experienced babysitter with a passion for helping children learn and grow. With over 5 years of childcare experience, I’m dedicated to creating a safe, nurturing environment where kids can feel comfortable, be themselves, and have fun.

  //         I hold a First Aid and CPR certification and have experience with children of various age groups, from infants to pre-teens. I enjoy reading stories, playing games, and organizing creative activities that keep children engaged and entertained. I understand how important communication is, and I always keep parents updated throughout my timestamp with their children.

  //         In my free timestamp, I enjoy volunteering, hiking, and baking treats for my family and friends. I look forward to meeting you and your little ones soon!""",
  //     experience: [
  //       'Infant Care',
  //       'CPR & First Aid Certified',
  //       'Meal Preparation',
  //       'Homework Assistance',
  //       'Behavior Management',
  //     ],
  //   ),
  //   Babysitter(
  //     babysitterID: 'babysitter02',
  //     name: 'Anthony Parr',
  //     email: 'anthonyparr@gmail.com',
  //     img: 'assets/images/male2.jpg',
  //     address: 'Davao City',
  //     phone: '+639123456789',
  //     birtdate: DateTime(2003, 12, 25),
  //     gender: 'Male',
  //     rate: 200,
  //     description:
  //         "Hello! My name is Anthony, and I'm a caring, experienced babysitter with a passion for helping children learn and grow. With over 5 years of childcare experience, I’m dedicated to creating a safe, nurturing environment where kids can feel comfortable, be themselves, and have fun. \nI hold a First Aid and CPR certification and have experience with children of various age groups, from infants to pre-teens. I enjoy reading stories, playing games, and organizing creative activities that keep children engaged and entertained. I understand how important communication is, and I always keep parents updated throughout my timestamp with their children. \nIn my free timestamp, I enjoy volunteering, hiking, and baking treats for my family and friends. I look forward to meeting you and your little ones soon!",
  //     experience: [
  //       'Infant Care',
  //       'Meal Preparation',
  //       'Behavior Management',
  //     ],
  //   ),
  // ];

  // List<Rating> ratingAndReviewList = [
  //   Rating(
  //     userID: 'user1',
  //     babysitterID: 'babysitter01',
  //     rating: 5,
  //     review: 'Very nice and friendly.',
  //     timestamp: DateTime(2024, 01, 01),
  //   ),
  //   Rating(
  //     userID: 'user1',
  //     babysitterID: 'babysitter01',
  //     rating: 5,
  //     review: 'Very nice and friendly.',
  //     timestamp: DateTime(2024, 01, 01),
  //     images: [
  //       'assets/images/female5.jpg',
  //     ],
  //   ),
  //   Rating(
  //     userID: 'user1',
  //     babysitterID: 'babysitter01',
  //     rating: 5,
  //     review: 'Very nice and friendly.',
  //     timestamp: DateTime(2024, 01, 01),
  //     images: [
  //       'assets/images/male1.jpg',
  //       'assets/images/male2.jpg',
  //     ],
  //   ),
  //   Rating(
  //     userID: 'user1',
  //     babysitterID: 'babysitter01',
  //     rating: 5,
  //     review:
  //         'Very nice and friendly.Very nice and friendly.Very nice and friendly.Very nice and friendly.Very nice and friendly.Very nice and friendly.Very nice and friendly.',
  //     timestamp: DateTime(2024, 01, 01),
  //     images: [
  //       'assets/images/female1.jpg',
  //       'assets/images/female2.jpg',
  //       'assets/images/female3.jpg',
  //       'assets/images/female4.jpg',
  //     ],
  //   ),
  // ];

  List<String> offerList = [
    '100',
    '200',
    '300',
  ];
}
