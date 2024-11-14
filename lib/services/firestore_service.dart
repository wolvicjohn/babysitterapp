import 'package:babysitterapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  // initiate firebase authentication
  final firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // call the collection from firestore
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  // Create new user account and add user data
  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
    required String role,
    required String phone,
  }) async {
    try {
      // Create user in Firebase Auth
      final UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final String uid = userCredential.user!.uid;

      // Create UserModel instance
      final UserModel newUser = UserModel(
        role: role,
        email: email,
        name: name,
        phone: phone,
      );

      // Convert to map and save to Firestore
      await users.doc(uid).set(newUser.toMap());
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  // load data of current user
  Future<UserModel?> loadUserData() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) return null;

      final doc = await firestore.collection('users').doc(user.uid).get();

      if (doc.exists) {
        return UserModel.fromMap(doc.data()!);
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
    return null;
  }

  // save data after editing
  Future<void> saveUserData(UserModel userModel) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) return;

      await firestore
          .collection('users')
          .doc(user.uid)
          .update(userModel.toMap());
    } catch (e) {
      print('Error saving user data: $e');
      rethrow;
    }
  }

  // log out user
  Future<void> signOutUser() async {
    try {
      await firebaseAuth.signOut();
      print("User signed out successfully.");
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
