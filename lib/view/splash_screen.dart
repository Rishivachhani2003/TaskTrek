import 'dart:async';
import 'package:flutter/material.dart';
import 'package:to_do_riverpod/constants/firebase_consts.dart';
import 'package:to_do_riverpod/view/home_page.dart';
import 'package:to_do_riverpod/view/login_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 2), () async {
      if (await auth.currentUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => MyHomePage()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (c) => LoginView()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hello, Welcome in Notes"),
          SizedBox(
            height: 15,
          ),
          CircularProgressIndicator(),
        ],
      ),
    ));
  }
}
