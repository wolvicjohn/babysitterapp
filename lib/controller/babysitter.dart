//NOTE: This is temporary babysitter data fields

class Babysitter {
  final String babysitterID;
  final String name;
  final String email;
  final String img;
  final String address;
  final String phone;
  final DateTime birtdate;
  final String gender;
  final int rate;
  final String description;
  final List experience;

  bool? isClicked = false;

  Babysitter({
    required this.babysitterID,
    required this.name,
    required this.email,
    required this.img,
    required this.address,
    required this.phone,
    required this.birtdate,
    required this.gender,
    required this.rate,
    required this.description,
    required this.experience,
    this.isClicked,
  });
}
