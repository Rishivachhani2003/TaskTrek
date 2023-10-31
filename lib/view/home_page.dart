// // // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, unnecessary_string_interpolations

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
import 'package:to_do_riverpod/view/login_view.dart';
import 'package:to_do_riverpod/widget/card_todo_widget.dart';
import 'package:to_do_riverpod/widget/logout_dialog.dart';

class MyHomePage extends ConsumerWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "ToDoApp",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
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
      body: FutureBuilder(
        future: controller.getUserData(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              UserModel userData = snapshot.data as UserModel;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Today's Task",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "${DateFormat("EEEEE, dd MMMM").format(DateTime.now())}",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFD5EBFA),
                              foregroundColor: Colors.blue.shade800,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => AddNewTaskModel()));
                          },
                          child: Text(
                            "+ New task",
                          ),
                        ),
                      ],
                    ),
                    Gap(20),
                    TaskListView(
                      userid: userData.id,
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: Text("No Data!"),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Center(
                child: Text("Something went Wrong"),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
