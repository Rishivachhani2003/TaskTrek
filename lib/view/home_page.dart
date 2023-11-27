// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, unnecessary_string_interpolations, unused_import, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_riverpod/common/new_task_page.dart';
import 'package:to_do_riverpod/constants/firebase_consts.dart';
import 'package:to_do_riverpod/controller/home_controller.dart';
import 'package:to_do_riverpod/enums/menu_action.dart';
import 'package:to_do_riverpod/model/usermodel.dart';
import 'package:to_do_riverpod/services/local_notification.dart';
import 'package:to_do_riverpod/view/login_view.dart';
import 'package:to_do_riverpod/widget/card_todo_widget.dart';
import 'package:to_do_riverpod/widget/logout_dialog.dart';

class MyHomePage extends ConsumerWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = Get.put(HomeController());

    // Use MediaQuery to get screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Responsive padding
    EdgeInsets pagePadding =
        EdgeInsets.symmetric(horizontal: screenWidth * 0.05);

    // Responsive font size
    double headingFontSize = screenWidth > 600 ? 24.0 : 20.0;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        elevation: 10,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "TaskTrek",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${DateFormat("EEEEE, dd MMMM").format(DateTime.now())}",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.calendar),
                ),
                PopupMenuButton(
                  onSelected: (value) async {
                    switch (value) {
                      case MenuAction.logout:
                        final shouldLogout = await showLogOutDialog(context);
                        if (shouldLogout) {
                          await auth.signOut();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) => LoginView()));
                        }
                    }
                  },
                  itemBuilder: (context) {
                    return const [
                      PopupMenuItem(
                        value: MenuAction.logout,
                        child: Text('LogOut'),
                      )
                    ];
                  },
                )
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: pagePadding,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  return
                      // Padding(
                      // padding: pagePadding,
                      // child:
                      TaskListView(
                    userid: userData.id,
                    // ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return Center(
                    child: Text("Something Went Wrong"),
                  );
                }
              } else {
                return Padding(
                  // padding: EdgeInsets.all(12),
                  padding: EdgeInsets.only(
                      top: screenHeight / 2, bottom: screenHeight / 2),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => AddNewTaskModel()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
