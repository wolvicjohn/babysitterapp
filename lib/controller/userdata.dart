//NOTE: This is temporary user data

import 'babysitter.dart';
import 'currentuser.dart';
import 'rating.dart';

class UserData {
  CurrentUser currentUser = CurrentUser(
    name: 'Sebastian Abraham',
    email: 'sebastianabraham@gmail.com',
    id: 'sebastian123',
    img: 'assets/images/male1.jpg',
  );

  List<Babysitter> babysitterList = [
    Babysitter(
      id: 'sample',
      email: 'emmagill@gmail.com',
      name: 'Emma Gill',
      img: 'assets/images/female1.jpg',
      address: 'Panabo City',
      phone: '+639123456789',
      age: 21,
      rating: 0,
    ),
    Babysitter(
      id: 'helloworld',
      email: 'anthonyparr@gmail.com',
      name: 'Anthony Parr',
      img: 'assets/images/male2.jpg',
      address: 'Davao City',
      phone: '+639123456789',
      age: 22,
      rating: 0,
    ),
    Babysitter(
      id: 'hiearth',
      email: 'carlgibson@gmail.com',
      name: 'Carl Gibson',
      img: 'assets/images/male3.jpg',
      address: 'Tagum City',
      phone: '+639123456789',
      age: 23,
      rating: 0,
    ),
    Babysitter(
      id: 'heymars',
      email: 'samanthabond.com',
      name: 'Samantha	Bond',
      img: 'assets/images/female2.jpg',
      address: 'Manila City',
      phone: '+639123456789',
      age: 24,
      rating: 0,
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

  List<String> offerList = [
    '100',
    '200',
    '300',
  ];
}
