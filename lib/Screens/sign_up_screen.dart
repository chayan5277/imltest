// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constants/spacing.dart';
import '../Controllers/login_controller.dart';
import '../Extra Widgets/custom_button.dart';
import '../Extra Widgets/custom_text_field.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool passwordVisible = true;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: loginController.fromKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
              children: [
                spacing(200),
                textField(
                  obscure: false,
                  keyboard: TextInputType.text,
                  fillColor: Colors.white,
                  showPrefixIcon: false,
                  maxLines: 1,
                  borderRadius: 100,
                  hintText: 'Enter your email',
                  controller: loginController.emailController,
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
                textField(
                  keyboard: TextInputType.text,
                  fillColor: Colors.white,
                  showPrefixIcon: false,
                  maxLines: 1,
                  borderRadius: 100,
                  hintText: 'Password',
                  controller: loginController.passwordController,
                  obscure: passwordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                spacing(20),
                textField(
                  keyboard: TextInputType.text,
                  fillColor: Colors.white,
                  showPrefixIcon: false,
                  maxLines: 1,
                  borderRadius: 100,
                  hintText: 'Confirm password',
                  controller: loginController.confirmPasswordController,
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
                  buttonText: 'SignUp',
                  radius: 100,
                  buttonTextColor: Colors.white,
                  buttonColor: const Color(0xff04BA9B),
                  onTapFunction: () {
                    if (loginController.fromKey.currentState!.validate()) {
                      setState(() {
                        loginController.email =
                            loginController.emailController.text;
                        loginController.password =
                            loginController.passwordController.text;
                        loginController.confirmPassword =
                            loginController.confirmPasswordController.text;
                      });
                      loginController.registration(context);
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                 Text('Already have an account?',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  const LoginScreen(),
                              transitionDuration: const Duration(seconds: 0)),
                        );
                      },
                      child:Text('Login',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
