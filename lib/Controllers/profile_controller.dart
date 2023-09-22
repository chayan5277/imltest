import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Models/profile_model.dart';

class ProfileController extends GetxController {
  final Rx<List<UserModel>> _profileList = Rx<List<UserModel>>([]);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  List<UserModel> get profile => _profileList.value;
  final TextEditingController image = TextEditingController();
  final TextEditingController newNameController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController newExperienceController = TextEditingController();
  final TextEditingController newSkillsController = TextEditingController();

  XFile? profileImgPath;

  Future uploadImageTofirebase(
    BuildContext context,
    String name,
    String email,
    String experience,
    String skills,
  ) async {
    String fileName = basename(profileImgPath!.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference reference = storage.ref().child('images/$fileName');
    UploadTask uploadTask = reference.putFile(File(profileImgPath!.path));
    uploadTask.then((res) async {
      String imageUrl = await (await uploadTask).ref.getDownloadURL();
      print(imageUrl);
      update();
      image.text = imageUrl;

      // Show success Snackbar here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Profile created successfully',
            style: TextStyle(fontSize: 20, color: Colors.green),
          ),
        ),
      );
    }).whenComplete(() {
      addProfile(
        image: image.text,
        name: name,
        email: email,
        experience: experience,
        skills: skills,
      );
      profileImgPath = XFile('');
    });
  }

  @override
  void onReady() {
    _profileList.bindStream(profileStream());
  }

  Stream<List<UserModel>> profileStream() {
    return FirebaseFirestore.instance
        .collection('Users')
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> pro = [];
      for (var student in query.docs) {
        final newUserModel =
            UserModel.fromDocumentSnapshot(documentSnapshot: student);
        pro.add(newUserModel);
      }
      return pro;
    });
  }

  addProfile({
    required String image,
    required String name,
    required String email,
    required String experience,
    required String skills,
  }) async {
    var addProfileData = Map<String, dynamic>();
    addProfileData['profileImgPath'] = image;
    addProfileData['name'] = name;
    addProfileData['email'] = email;
    addProfileData['experience'] = experience;
    addProfileData['skills'] = skills;
    print(addProfileData.entries);
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc()
        .set(addProfileData, SetOptions(merge: true));
  }

  // This is a users delete  data function......

  Future deleteData(id) async {
    await FirebaseFirestore.instance.collection("Users").doc(id).delete();
  }
}
