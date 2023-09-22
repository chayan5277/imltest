import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  final String? image;
  final String name, email, experience;
  final String skills;
  ProfileModel(
      {this.image,
      required this.name,
      required this.email,
      required this.experience,
      required this.skills});

  // Convert the model to a map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'Image': image,
      'Name': name,
      'Email': email,
      'Experience': experience,
      'Skills': skills,
    };
  }
}

class UserModel {
  String? documentId;
  late final String image;
  late String name, email, experience;
  late String skills;

  UserModel({
    required this.image,
    required this.name,
    required this.email,
    required this.experience,
    required this.skills,
  });

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    documentId = documentSnapshot.id;
    image = documentSnapshot['profileImgPath'] ?? '';
    name = documentSnapshot['name'] ?? '';
    email = documentSnapshot['email'] ?? '';
    experience = documentSnapshot['experience'] ?? '';
    skills = documentSnapshot['skills'] ?? '';
  }
}
