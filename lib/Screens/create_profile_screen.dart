// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Constants/responsive_constants.dart';
import '../Constants/spacing.dart';
import '../Controllers/profile_controller.dart';
import '../Extra Widgets/custom_button.dart';
import '../Extra Widgets/custom_text_field.dart';
import 'profile_lists_screen.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final ImagePicker picker = ImagePicker();

  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Data'),backgroundColor: Colors.orange),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  spacing(constraints.maxHeight * 0.02),
                  GestureDetector(
                      onTap: () async {
                        profileController.profileImgPath =
                            await picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          print(profileController.profileImgPath!.path);
                        });
                      },
                      child: Center(
                          child: CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.orange,
                              child: profileController.profileImgPath == null ||
                                      profileController.profileImgPath!.path ==
                                          ""
                                  ? const ClipOval(
                                      child: Text('Add Image',style: TextStyle(color: Colors.white),))
                                  : ClipOval(
                                      child: Image.file(
                                          File(profileController
                                              .profileImgPath!.path),
                                          width: 160,
                                          height: 160,
                                          fit: BoxFit.cover))))),
                  spacing(30),
                  textField(
                      showPrefixIcon: false,
                      maxLines: 1,
                      fillColor: const Color(0xffFFFFFF),
                      labelText: 'Name',
                      controller: profileController.nameController,
                      hintText: 'Enter your name',
                      keyboard: TextInputType.text,
                      borderRadius: 100,
                      obscure: false),
                  spacing(20),
                  textField(
                    showPrefixIcon: false,
                    controller: profileController.emailController,
                    keyboard: TextInputType.text,
                    labelText: "Email",
                    hintText: ' Email',
                    onTap: () {},
                    fillColor: Colors.white,
                    borderRadius: 100,
                    obscure: false,
                  ),
                  spacing(20),
                  textField(
                    showPrefixIcon: false,
                    controller: profileController.skillsController,
                    keyboard: TextInputType.text,
                    labelText: "Skills",
                    hintText: ' Skills',
                    onTap: () {},
                    fillColor: Colors.white,
                    borderRadius: 100,
                    obscure: false,
                  ),
                  spacing(20),
                  textField(
                    showPrefixIcon: false,
                    controller: profileController.experienceController,
                    keyboard: TextInputType.text,
                    labelText: "Experience",
                    hintText: 'Experience',
                    onTap: () {},
                    fillColor: Colors.white,
                    borderRadius: 100,
                    obscure: false,
                  ),
                  spacing(constraints.maxHeight * 0.04),
                  CustomButton(
                    buttonHeight: screenHeight(context) * 0.067,
                    buttonText: 'Create Profile',
                    buttonTextColor: Colors.white,
                    buttonColor: Colors.orange,
                    onTapFunction: () {
                      profileController.uploadImageTofirebase(
                        context,
                        profileController.nameController.text,
                        profileController.emailController.text,
                        profileController.experienceController.text,
                        profileController.skillsController.text,
                      );
                      Get.to(() => const ProfileLists());
                    },
                    radius: 100,
                    gradientColors: const [Colors.orange, Colors.yellow],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
