import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../Controllers/profile_controller.dart';
import '../Extra Widgets/app_bar.dart';
import 'edit_profile_screen.dart';
import 'profile_screen.dart';

class ProfileLists extends StatefulWidget {
  const ProfileLists({
    Key? key,
  }) : super(key: key);
  @override
  State<ProfileLists> createState() => _ProfileListsState();
}

class _ProfileListsState extends State<ProfileLists> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.orange,
      appBar: GradientAppBar(title: 'Profile Lists'),
      body: Obx(() => ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: profileController.profile.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: GestureDetector(
                  onTap: () {
                    Get.to(() => ProfileScreen(
                          image: profileController.profile[index].image,
                          name: profileController.profile[index].name,
                          email: profileController.profile[index].email,
                          experience:
                              profileController.profile[index].experience,
                          skills: profileController.profile[index].skills,
                          profileID: profileController.profile[index].documentId
                              .toString(),
                        ));
                  },
                  child: Card(
                      elevation: 2,
                      child: ListTile(
                          leading: GestureDetector(
                              onTap: () {},
                              child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.orange,
                                  child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                        profileController.profile[index].image,
                                      )))),
                          title: Text(profileController.profile[index].name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                          subtitle:
                              Text(profileController.profile[index].email),
                          trailing:
                              Row(mainAxisSize: MainAxisSize.min, children: [
                            IconButton(
                                onPressed: () {
                                  profileController.deleteData(profileController
                                      .profile[index].documentId
                                      .toString());
                                },
                                icon: const Icon(Icons.delete,color: Colors.red,)),
                          ])))),
            );
          })),
    );
  }
}
