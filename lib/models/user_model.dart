// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  // general
  final String id;
  final String role;
  final String email;
  final String name;
  String? img;
  final String gender;
  final GeoPoint address;
  final String phone;
  final String information;
  final DateTime age;
  // parent-specific
  int? childAge;
  // babysitter-specific
  List? experience;
  double? rating;
  double? rate;

  UserModel(
      {required this.id,
      required this.role,
      required this.email,
      required this.name,
      this.img,
      required this.gender,
      required this.address,
      required this.phone,
      required this.information,
      required this.age,
      this.childAge,
      this.experience,
      this.rating,
      this.rate});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'role': role,
      'email': email,
      'name': name,
      'img': img,
      'gender': gender,
      'address': address,
      'phone': phone,
      'information': information,
      'age': age.millisecondsSinceEpoch,
      'childAge': childAge,
      'experience': experience,
      'rating': rating,
      'rate': rate,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      role: map['role'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      img: map['img'] != null ? map['img'] as String : null,
      gender: map['gender'] as String,
      address: map['address'] as GeoPoint,
      phone: map['phone'] as String,
      information: map['information'] as String,
      age: DateTime.fromMillisecondsSinceEpoch(map['age'] as int),
      childAge: map['childAge'] != null ? map['childAge'] as int : null,
      experience: map['experience'] != null ? map['experience'] as List : null,
      rating: map['rating'] != null ? map['rating'] as double : null,
      rate: map['rate'] != null ? map['rate'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
