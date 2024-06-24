import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/src/screens/Home/home_screen.dart';
import 'package:myapp/src/screens/welcome/welcome_screen.dart';

class Authentication extends GetxController {
  static Authentication get insatnce => Get.find();

  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;
  var userData = {}.obs;
  late Rx<User?> firebaseUser;

  @override
  void onInit() {
    super.onInit();
    firebaseUser = Rx<User?>(_auth.currentUser);
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    DocumentSnapshot doc =
        await _store.collection('Users').doc(firebaseUser.value!.uid).get();
    userData.value = doc.data() as Map<String, dynamic>;
  }

  Future<void> createUserwithEmailandPassword(String email, String password,
      String name, String phoneNo, context) async {
    try {
      final UserCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('User created with UID: ${UserCredential.user!.uid}');
      await _store.collection("Users").doc(UserCredential.user!.uid).set({
        "Name": name,
        "Phone": phoneNo,
        "Email": email,
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 3000),
          content: Text("Account Created successfully"),
        ),
      );
      Get.offAll(HomeScreen());
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 3000),
          content: Text(error.message ?? "Authentication Error"),
        ),
      );
    }
  }

  Future<void> loginUserwithEmailandPassword(
      String email, String password, context) async {
    try {
      final UserCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 3000),
          content: Text("Login successfully"),
        ),
      );

      Get.offAll(HomeScreen());
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 3000),
          content: Text(error.message ?? "Authentication Error"),
        ),
      );
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAll(WelcomeScreen());
  }
}
