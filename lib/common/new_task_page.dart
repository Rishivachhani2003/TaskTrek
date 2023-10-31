// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_riverpod/constants/app_style.dart';
import 'package:to_do_riverpod/controller/model_controller.dart';
import 'package:to_do_riverpod/controller/task_repository.dart';
import 'package:to_do_riverpod/model/todo_model.dart';
import 'package:to_do_riverpod/model/usermodel.dart';
import 'package:to_do_riverpod/provider/date_time_provider.dart';
import 'package:to_do_riverpod/provider/radio_provider.dart';
import 'package:to_do_riverpod/view/home_page.dart';
import 'package:to_do_riverpod/widget/datetime_widget.dart';
import 'package:to_do_riverpod/widget/radio_widget.dart';
import 'package:to_do_riverpod/widget/textfield_widget.dart';

class AddNewTaskModel extends ConsumerWidget {
  AddNewTaskModel({
    super.key,
  });

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = Get.put(TaskRepository());
    final modelrepo = Get.put(ModelController());
    return Scaffold(
      body: FutureBuilder(
        future: modelrepo.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel user = snapshot.data as UserModel;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "New Task Todo",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black),
                      ),
                    ),
                    Divider(
                      thickness: 1.2,
                      color: Colors.grey.shade200,
                    ),
                    Gap(12),
                    Text(
                      "Title Task",
                      style: AppStyle.headingOne,
                    ),
                    Gap(6),
                    TextFieldWidget(
                      txtController: titleController,
                      hintText: "Add New Task",
                      maxLine: 1,
                    ),
                    Gap(12),
                    Text(
                      "Description",
                      style: AppStyle.headingOne,
                    ),
                    Gap(6),
                    TextFieldWidget(
                      txtController: descriptionController,
                      hintText: "Add Description",
                      maxLine: 3,
                    ),
                    Gap(12),
                    Text(
                      "Category",
                      style: AppStyle.headingOne,
                    ),
                    Gap(6),
                    Row(
                      children: [
                        Expanded(
                          child: RadioWidget(
                            valueInput: 1,
                            titleRadio: "LRN",
                            categColor: Colors.green,
                            onChangeValue: () => ref
                                .read(radioProvider.notifier)
                                .update((state) => 1),
                          ),
                        ),
                        Expanded(
                          child: RadioWidget(
                            valueInput: 2,
                            titleRadio: "WRK",
                            categColor: Colors.blue.shade700,
                            onChangeValue: () => ref
                                .read(radioProvider.notifier)
                                .update((state) => 2),
                          ),
                        ),
                        Expanded(
                          child: RadioWidget(
                            valueInput: 3,
                            titleRadio: "GEN",
                            categColor: Colors.amberAccent.shade700,
                            onChangeValue: () => ref
                                .read(radioProvider.notifier)
                                .update((state) => 3),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DateTimeWidget(
                          titleText: "Date",
                          iconSection: CupertinoIcons.calendar,
                          valueText: ref.watch(dateProvider),
                          onTap: () async {
                            final getValue = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2025),
                            );
                            final format = DateFormat.yMd();
                            if (getValue != null) {
                              ref
                                  .read(dateProvider.notifier)
                                  .update((state) => format.format(getValue));
                            }
                          },
                        ),
                        Gap(22),
                        DateTimeWidget(
                          titleText: "Time",
                          iconSection: CupertinoIcons.clock,
                          valueText: ref.watch(timeProvider),
                          onTap: () async {
                            final getTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (getTime != null) {
                              ref
                                  .read(timeProvider.notifier)
                                  .update((state) => getTime.format(context));
                            }
                          },
                        ),
                      ],
                    ),
                    Gap(12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue.shade800,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              side: BorderSide(
                                color: Colors.blue.shade800,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                          ),
                        ),
                        Gap(20),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue.shade800,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              side: BorderSide(
                                color: Colors.blue.shade800,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () {
                              final getRadioValue = ref.read(radioProvider);
                              String category = '';
                              switch (getRadioValue) {
                                case 1:
                                  category = 'Learning';
                                  break;
                                case 2:
                                  category = 'Working';
                                  break;
                                case 3:
                                  category = 'General';
                                  break;
                              }
                              if (titleController.text.isEmpty) {
                                Fluttertoast.showToast(msg: "Task is Empty");
                              } else if (descriptionController.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Task description is Empty");
                              } else if (category == '') {
                                Fluttertoast.showToast(
                                    msg: "Category is Empty");
                              } else {
                                final model = TodoModel(
                                  titleTask: titleController.text,
                                  description: descriptionController.text,
                                  category: category,
                                  dateTask: ref.read(dateProvider),
                                  timeTask: ref.read(timeProvider),
                                  isDone: false,
                                );
                                controller.addNewTask(model, user);
                                titleController.clear();
                                descriptionController.clear();
                                ref
                                    .read(radioProvider.notifier)
                                    .update((state) => 0);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => MyHomePage()));
                              }
                            },
                            child: Text("Create"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
