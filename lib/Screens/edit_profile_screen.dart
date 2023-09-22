import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Constants/spacing.dart';
import '../Controllers/profile_controller.dart';
import '../Extra Widgets/app_bar.dart';
import '../Extra Widgets/custom_button.dart';
import '../Extra Widgets/custom_text_field.dart';
import 'profile_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.profileID});
  final String profileID;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    final ProfileController profileController = Get.find<ProfileController>();
    return Scaffold(
      appBar: GradientAppBar(title: 'Edit Profile'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                  child: GestureDetector(
                      onTap: () async {
                        profileController.profileImgPath =
                            await picker.pickImage(source: ImageSource.gallery);
                        setState(() {});
                      },
                      child: profileController.profileImgPath == null ||
                              profileController.profileImgPath!.path == ""
                          ? ClipOval(
                              child: Image.network(profileController.image.text,
                                  width: 150, height: 150, fit: BoxFit.cover))
                          : ClipOval(
                              child: Image.file(
                                  File(profileController.profileImgPath!.path),
                                  width: 110,
                                  height: 110,
                                  fit: BoxFit.cover)))),
              spacing(30),
              textField(
                showPrefixIcon: false,
                controller: profileController.newNameController,
                keyboard: TextInputType.text,
                labelText: "Name",
                hintText: 'Update Your Name',
                onTap: () {},
                fillColor: Colors.white,
                borderRadius: 100,
                obscure: false,
              ),
              spacing(20),
              textField(
                showPrefixIcon: false,
                controller: profileController.newEmailController,
                keyboard: TextInputType.text,
                labelText: "Email",
                hintText: 'Update Your Email',
                onTap: () {},
                fillColor: Colors.white,
                borderRadius: 100,
                obscure: false,
              ),
              spacing(20),
              textField(
                showPrefixIcon: false,
                controller: profileController.newSkillsController,
                keyboard: TextInputType.text,
                labelText: "Skills",
                hintText: 'Update Your Skills',
                onTap: () {},
                fillColor: Colors.white,
                borderRadius: 100,
                obscure: false,
              ),
              spacing(20),
              textField(
                showPrefixIcon: false,
                controller: profileController.newExperienceController,
                keyboard: TextInputType.text,
                labelText: "Experience",
                hintText: 'Update Your Experience',
                onTap: () {},
                fillColor: Colors.white,
                borderRadius: 100,
                obscure: false,
              ),
              spacing(20),
              CustomButton(
                gradientColors: const [Colors.orange, Colors.yellow],
                buttonColor: const Color(0xff2B7CFC),
                buttonText: 'Update',
                onTapFunction: () async {
                  if (profileController.profileImgPath!.name == "") {
                    final documentReference = FirebaseFirestore.instance
                        .collection('Users')
                        .doc(widget.profileID);
                    documentReference.update({
                      'profileImgPath': profileController.image.text,
                      'name': profileController.newNameController.text,
                      'email': profileController.newEmailController.text,
                      'experience':
                          profileController.newExperienceController.text,
                      'skills': profileController.newSkillsController.text,
                    });
                  } else {
                    FirebaseStorage storage = FirebaseStorage.instance;
                    Reference ref = storage.ref().child(
                        'image/${profileController.profileImgPath!.name}');
                    UploadTask uploadTask = ref
                        .putFile(File(profileController.profileImgPath!.path));
                    uploadTask.then((res) async {
                      String imageUrl =
                          await (await uploadTask).ref.getDownloadURL();
                      final documentReference = FirebaseFirestore.instance
                          .collection('Users')
                          .doc(widget.profileID);
                      documentReference.update({
                        'profileImgPath': imageUrl,
                        'name': profileController.newNameController.text,
                        'email': profileController.newEmailController.text,
                        'experience':
                            profileController.newExperienceController.text,
                        'skills': profileController.newSkillsController.text,
                      }).whenComplete(() {
                        // Show success Snackbar here
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Profile Updated successfully',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.orange),
                            ),
                          ),
                        );
                        Get.offAll(() => ProfileScreen(
                            image: imageUrl,
                            name: profileController.newNameController.text,
                            email: profileController.emailController.text,
                            experience:
                                profileController.newExperienceController.text,
                            skills: profileController.newSkillsController.text,
                            profileID: widget.profileID));
                      });
                    });
                  }
                },
                buttonTextColor: Colors.white,
                radius: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
