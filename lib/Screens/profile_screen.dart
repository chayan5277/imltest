import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../Controllers/login_controller.dart';
import '../Controllers/profile_controller.dart';
import '../Extra Widgets/app_bar.dart';
import '../Extra Widgets/custom_button.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.image,
    required this.name,
    required this.email,
    required this.experience,
    required this.skills,
    required this.profileID,
  });
  final String image;
  final String name;
  final String email;
  final String experience;
  final String skills;
  final String profileID;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();
    return Scaffold(
        appBar: GradientAppBar(
          title: 'My Profile',
          icon: Icons.logout_outlined,
          onTapFunction: () {
            loginController.logout();
          },
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Center(
                  child: CircleAvatar(
                      radius: 90, backgroundImage: NetworkImage(widget.image))),
            Text(
                'Name :',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.w600,color: Colors.orange),

              ),
              Text(
                profileController.nameController.text,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
       Text(
                'Email:',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.w600,color: Colors.orange),

              ),
              Text(
                profileController.emailController.text,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w600,),
              ),
             Text(
                'Skills:',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.w600,color: Colors.orange),

              ),
              Text(
                profileController.skillsController.text,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
          Text(
                'Experience:',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.w600,color: Colors.orange),

              ),
              Text(profileController.experienceController.text,
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.w600)),
              CustomButton(
                gradientColors: const [Colors.orange, Colors.yellow],
                buttonColor: const Color(0xff2B7CFC),
                buttonText: 'Edit Profile',
                onTapFunction: () {
                  profileController.newNameController.text = widget.name;
                  profileController.newEmailController.text = widget.email;
                  profileController.image.text = widget.image;
                  profileController.newSkillsController.text = widget.skills;
                  profileController.newExperienceController.text =
                      widget.experience;
                  Get.to(() => EditProfileScreen(
                        profileID: widget.profileID,
                      ));
                },
                buttonTextColor: Colors.white,
                radius: 12,
              )
            ],
          ),
        ));
  }
}
