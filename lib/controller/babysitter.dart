//NOTE: This is temporary babysitter data fields

class Babysitter {
  final String id;
  final String email;
  final String name;
  final String img;
  final String address;
  final String phone;
  final int age;
  double rating;
  bool? isClicked = false;

  Babysitter({
    required this.id,
    required this.email,
    required this.name,
    required this.img,
    required this.address,
    required this.phone,
    required this.age,
    required this.rating,
    this.isClicked,
  });
}
