//NOTE: This is temporary user data

import 'babysitter.dart';
import 'currentuser.dart';
import 'rating.dart';

class UserData {
  CurrentUser currentUser = CurrentUser(
    name: 'Sebastian	Abraham',
    email: 'sebastianabraham@gmail.com',
    id: 'sebastian123',
    img: 'assets/images/male1.jpg',
  );

  List<Babysitter> babysitterList = [
    Babysitter(
      email: 'emmagill@gmail.com',
      name: 'Emma	Gill',
      id: 'sample',
      img: 'assets/images/female1.jpg',
      rating: 0,
      isClicked: false,
    ),
    Babysitter(
      email: 'anthonyparr@gmail.com',
      name: 'Anthony Parr',
      id: 'helloworld',
      img: 'assets/images/male2.jpg',
      rating: 0,
      isClicked: false,
    ),
    Babysitter(
      email: 'carlgibson@gmail.com',
      name: 'Carl Gibson',
      id: 'hiearth',
      img: 'assets/images/male3.jpg',
      rating: 0,
      isClicked: false,
    ),
    Babysitter(
      email: 'samanthabond.com',
      name: 'Samantha	Bond',
      id: 'heymars',
      img: 'assets/images/female2.jpg',
      rating: 0,
      isClicked: false,
    ),
  ];

  List<Rating> ratingAndReviewList = [
    Rating(
      id: 'sample',
      rating: 5,
      review: 'Very nice and friendly.',
    ),
    Rating(
      id: 'sample',
      rating: 4,
      review: 'My son likes her.',
    ),
    Rating(
      id: 'sample',
      rating: 4,
      review: 'Kind.',
    ),
    Rating(
      id: 'helloworld',
      rating: 3,
      review: 'Good.',
    ),
    Rating(
      id: 'helloworld',
      rating: 3,
      review: 'Responsible',
    ),
    Rating(
      id: 'helloworld',
      rating: 4,
      review: 'Better',
    ),
    Rating(
      id: 'hiearth',
      rating: 1,
      review: 'Not good.',
    ),
    Rating(
      id: 'hiearth',
      rating: 2,
      review: 'Will not choose her again',
    ),
  ];
}
