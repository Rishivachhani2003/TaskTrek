// ignore_for_file: await_only_futures, prefer_const_constructors

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
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.all(constraints.maxWidth * 0.1),
                  child: Container(
                    height: constraints.maxHeight * 0.4,
                    width: constraints.maxWidth * 0.8,
                    decoration: BoxDecoration(),
                    child: Image.asset("assets/images/launcher_icon.png"),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.03,
                ),
                Text("Hello, Welcome to TaskTrek"),
                SizedBox(
                  height: constraints.maxHeight * 0.03,
                ),
                CircularProgressIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }
}
