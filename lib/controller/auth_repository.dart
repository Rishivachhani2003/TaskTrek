// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:to_do_riverpod/constants/firebase_consts.dart';
import 'package:to_do_riverpod/view/home_page.dart';
import 'package:to_do_riverpod/view/splash_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  late final Rx<User?> _firebaseUser;
  User? get firebaseUser => _firebaseUser.value;

  String get getUserId => firebaseUser?.uid ?? "";
  String get getUserEmail => firebaseUser?.email ?? "";

  @override
  void onReady() {
    _firebaseUser = Rx<User?>(auth.currentUser);
    _firebaseUser.bindStream(auth.userChanges());
    ever(_firebaseUser, setInitialScreen);
  }

  setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => SplashScreen())
        : Get.offAll(() => MyHomePage());
  }

  Future<void> signup(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  Future<bool> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
    return true;
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
