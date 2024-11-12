import 'package:babysitterapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  // initiate firebase authentication
  final firebaseAuth = FirebaseAuth.instance;
  // call the collection from firestore
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  // add user account and data to database
  Future<void> addUser(String? email, String? password, String? fullName,
      String? role, String? phoneNumber) async {
    firebaseAuth
        .createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    )
        .then((userCredential) async {
      users.doc(userCredential.user!.email).set({
        "email": userCredential.user!.email,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "role": role
      });
    });
  }

  // get data for current user
  Future<Map<String, dynamic>?> getCurrentUserData() async {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.email)
          .get();
      return userDoc.data();
    }
    return null;
  }
}
