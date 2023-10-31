import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:to_do_riverpod/controller/home_controller.dart';
import 'package:to_do_riverpod/controller/task_repository.dart';
import 'package:to_do_riverpod/widget/delete_note_dialog.dart';

class TaskListView extends StatefulWidget {
  final userid;
  const TaskListView({
    super.key,
    required this.userid,
  });

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final taskRepo = Get.put(TaskRepository());
    return FutureBuilder(
      future: controller.getTodoData(
        id: widget.userid,
      ),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Color categoryColor = Colors.white;
                final getCategory = snapshot.data![index].category;
                switch (getCategory) {
                  case 'Learning':
                    categoryColor = Colors.green;
                    break;
                  case 'Working':
                    categoryColor = Colors.blue.shade700;
                    break;
                  case 'General':
                    categoryColor = Colors.amber.shade700;
                    break;
                }
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: categoryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                        width: 30,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: IconButton(
                                  icon: Icon(
                                    CupertinoIcons.delete,
                                  ),
                                  onPressed: () async {
                                    final shouldDelete =
                                        await showDeleteDialog(context);
                                    if (shouldDelete) {
                                      taskRepo.deleteTask(
                                        userid: widget.userid,
                                        todoid: snapshot.data![index].docID,
                                      );
                                      setState(() {});
                                    }
                                  },
                                ),
                                title: Text(
                                  snapshot.data![index].titleTask,
                                  maxLines: 1,
                                  style: TextStyle(
                                    decoration: snapshot.data![index].isDone
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                                subtitle: Text(
                                  snapshot.data![index].description,
                                  maxLines: 1,
                                  style: TextStyle(
                                    decoration: snapshot.data![index].isDone
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                                trailing: Transform.scale(
                                  scale: 1.5,
                                  child: Checkbox(
                                      activeColor: Colors.blue.shade800,
                                      value: snapshot.data![index].isDone,
                                      shape: CircleBorder(),
                                      onChanged: (value) {
                                        taskRepo.updateTask(
                                          userid: widget.userid,
                                          todoid: snapshot.data![index].docID,
                                          valueUpdate: value,
                                        );
                                        setState(() {});
                                      }),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(0, -12),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Divider(
                                        thickness: 1.5,
                                        color: Colors.grey.shade200,
                                      ),
                                      Row(
                                        children: [
                                          Text(snapshot.data![index].dateTask),
                                          Gap(12),
                                          Text(snapshot.data![index].timeTask),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
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
    );
  }
}
