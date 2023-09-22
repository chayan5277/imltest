// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Screens/create_profile_screen.dart';
import '../Screens/login_screen.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final fromKey = GlobalKey<FormState>();
  userLogin(BuildContext context) async {
    try {
      String enteredEmail = emailController.text;
      String enteredPassword = passwordController.text;
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: enteredEmail,
        password: enteredPassword,
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Login Successfully. Please create your profile',
          style: TextStyle(fontSize: 20, color: Colors.amber),
        ),
      ));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const CreateProfileScreen()));
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print('No user found for that email');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'No user found for that email',
            style: TextStyle(fontSize: 20, color: Colors.amber),
          ),
        ));
      } else if (error.code == 'wrong-password') {
        print('Wrong Password provided by the user');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Wrong Password provided by the user',
            style: TextStyle(fontSize: 20, color: Colors.amber),
          ),
        ));
      }
    }
  }

  var email = "";
  var password = "";
  var confirmPassword = "";
  final confirmPasswordController = TextEditingController();
  registration(BuildContext context) async {
    if (password == confirmPassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Registered Successfully. Please create your profile',
            style: TextStyle(fontSize: 20, color: Colors.amber),
          ),
        ));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const CreateProfileScreen()));
      } on FirebaseAuthException catch (error) {
        if (error.code == 'weak-password') {
          print('Password is too weak');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'Password is too weak',
              style: TextStyle(fontSize: 20, color: Colors.amber),
            ),
          ));
        } else if (error.code == 'email-already-in-use') {
          print('Account is already exists');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'Account is already exists',
              style: TextStyle(fontSize: 20, color: Colors.amber),
            ),
          ));
        }
      }
    } else {
      print('Password and Confirm Password does not match');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Password and Confirm Password does not match',
          style: TextStyle(fontSize: 20, color: Colors.amber),
        ),
      ));
    }
  }

  // Add a function for logout
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate back to the login screen
      Get.offAll(() =>
          const LoginScreen()); // Assuming LoginScreen is your login screen widget
    } catch (error) {
      print('Error logging out: $error');
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
