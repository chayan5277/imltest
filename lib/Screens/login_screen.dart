// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Constants/responsive_constants.dart';
import '../Constants/spacing.dart';
import '../Controllers/login_controller.dart';
import '../Extra Widgets/custom_button.dart';
import '../Extra Widgets/custom_text_field.dart';
import 'create_profile_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = true;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  var email = "";
  var password = "";
  bool checkBox = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final LoginController loginController = Get.put(LoginController());
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> loginWithGoogle(BuildContext context) async {
    var result = await googleSignIn.signIn();
    if (result != null) {
      final userData = await result.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: userData.accessToken,
        idToken: userData.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential).then((value) {
        Get.offAll(() => const CreateProfileScreen());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: loginController.fromKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                spacing(30),
                Center(
                  child: Image.asset(
                    'assets/gif/zip.gif',
                    height: screenHeight(context) * 0.3,
                  ),
                ),
                Center(
                  child: Text('Welcome To Login',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                      ),
                ),
                spacing(25),
                Text('Email',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    ),
                spacing(8),
                textField(
                  showPrefixIcon: false,
                  fillColor: Colors.white,
                  maxLines: 1,
                  controller: loginController.emailController,
                  hintText: 'Enter your email',
                  borderRadius: 100,
                  obscure: false,
                  keyboard: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    } else if (!value.contains('@')) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                ),
                spacing(20),
             Text('Password',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                spacing(8),
                textField(
                  showPrefixIcon: false,
                  fillColor: Colors.white,
                  maxLines: 1,
                  controller: loginController.passwordController,
                  hintText: 'Password',
                  borderRadius: 100,
                  keyboard: TextInputType.text,
                  suffixIcon: passwordVisible
                      ? CupertinoIcons.eye
                      : CupertinoIcons.eye_slash,
                  obscure: passwordVisible,
                  hidePassword: () {
                    passwordVisible = !passwordVisible;
                    setState(() {});
                    passwordVisible;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                spacing(20),
                CustomButton(
                  gradientColors: const [
                    Colors.orange,
                    Colors.yellow,
                  ],
                  radius: 100,
                  onTapFunction: () {
                    if (loginController.fromKey.currentState!.validate()) {
                      loginController.userLogin(context);
                    }
                  },
                  buttonText: 'Login',
                  buttonTextColor: Colors.white,
                  buttonColor: const Color(0xff04BA9B),
                ),
                spacing(10),
                InkWell(
                  onTap: () {

                        loginWithGoogle(context)
                        .then((value) => const CreateProfileScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.black)),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage(
                            'assets/googlepic.png',
                          ),
                          height: 20,
                        ),
                        gap(10),
                        const Text(
                          'Google',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: checkBox,
                    fillColor: const MaterialStatePropertyAll(
                      Colors.orange,
                    ),
                    onChanged: (value) {
                      setState(() {
                        checkBox = value!;
                      });
                    },
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(
                        color: Colors.orange,
                        width: 0.1,
                      ),
                    ),
                  ),
                  gap(5),
                  Expanded(
                    child: Text('Remember me',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                 Text('Do not have an account?',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                     ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (context, a, b) =>
                                    const SignUpScreen(),
                                transitionDuration: const Duration(seconds: 0)),
                            (route) => false);
                      },
                      child: Text('SignUp',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            letterSpacing: 0.2,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.orange
                          ),
                         ),
                    )
                  ],
                ),
                spacing(0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
