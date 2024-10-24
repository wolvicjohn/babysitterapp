//NOTE: This is temporary babysitter data fields

class Babysitter {
  final String email;
  final String name;
  final String id;
  final String img;
  double rating;
  bool? isClicked = false;

  Babysitter({
    required this.email,
    required this.name,
    required this.id,
    required this.img,
    required this.rating,
    this.isClicked,
  });
}
