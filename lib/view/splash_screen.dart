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
    Timer(const Duration(seconds: 5), () async {
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
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: MediaQuery.of(context).size.height - 500,
              width: MediaQuery.of(context).size.width - 100,
              decoration: BoxDecoration(),
              child: Image.asset(
                "assets/images/launcher_icon.png",
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text("Hello, Welcome in TaskTrek"),
          SizedBox(
            height: 15,
          ),
          CircularProgressIndicator(),
        ],
      ),
    ));
  }
}
