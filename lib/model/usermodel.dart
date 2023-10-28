import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? password;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return UserModel(
      id: document.id,
      name: data!['name'],
      email: data['email'],
      password: data['password'],
    );
  }
}
