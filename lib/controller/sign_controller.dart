import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_riverpod/controller/user_repository.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final userrepo = Get.put(UserRepository());

  Future<bool> checkIfEmailInUse(String emailAddress) async {
    try {
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);

      if (list.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return true;
    }
  }
}
