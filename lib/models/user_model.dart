import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  // general
  String role;
  String email;
  String name;
  String phone;

  // added later for accounts page
  String? img;
  String? gender;
  GeoPoint? location;
  String? address;
  String? information;
  DateTime? age;

  // parent-specific
  int? childAge;

  // babysitter-specific
  List? experience;
  double? rating;
  double? rate;

  UserModel({
    required this.role,
    required this.email,
    required this.name,
    required this.phone,
    this.img,
    this.gender,
    this.location,
    this.address,
    this.information,
    this.age,
    this.childAge,
    this.experience,
    this.rating,
    this.rate,
  });

  // Convert UserModel to Map
  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'email': email,
      'name': name,
      'phone': phone,
      'img': img ?? '',
      'gender': gender ?? 'Select Gender',
      'location': location ?? const GeoPoint(0, 0),
      'address': address ?? '',
      'information': information ?? 'No information provided',
      'age': age ?? DateTime(2000, 1, 1),
      'childAge': childAge ?? 0,
      'experience': experience ?? [],
      'rating': rating ?? 0.0,
      'rate': rate ?? 0.0,
    };
  }

  // Create UserModel from Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      role: map['role'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      img: map['img'],
      gender: map['gender'],
      location: map['location'],
      address: map['address'],
      information: map['information'],
      age: map['age']?.toDate(), // Convert Timestamp to DateTime
      childAge: map['childAge'],
      experience: map['experience'],
      rating: map['rating']?.toDouble(),
      rate: map['rate']?.toDouble(),
    );
  }

  // Add copyWith method
  UserModel copyWith({
    String? role,
    String? email,
    String? name,
    String? phone,
    String? img,
    String? gender,
    GeoPoint? location,
    String? address,
    String? information,
    DateTime? age,
    int? childAge,
    List? experience,
    double? rating,
    double? rate,
  }) {
    return UserModel(
      role: role ?? this.role,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      img: img ?? this.img,
      gender: gender ?? this.gender,
      location: location ?? this.location,
      address: address ?? this.address,
      information: information ?? this.information,
      age: age ?? this.age,
      childAge: childAge ?? this.childAge,
      experience: experience ?? this.experience,
      rating: rating ?? this.rating,
      rate: rate ?? this.rate,
    );
  }
}
