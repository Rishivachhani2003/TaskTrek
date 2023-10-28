import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:to_do_riverpod/constants/firebase_consts.dart';
import 'package:to_do_riverpod/model/todo_model.dart';
import 'package:to_do_riverpod/model/usermodel.dart';

class TaskRepository extends GetxController {
  static TaskRepository get instance => Get.find();
  addNewTask(TodoModel model, UserModel user) {
    try {
      firestore
          .collection(userCollection)
          .doc(user.id)
          .collection(todoCollection)
          .add(model.toJson());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<List<TodoModel>> getAllTodo({id}) async {
    final snapshot = await firestore
        .collection(userCollection)
        .doc(id)
        .collection(todoCollection)
        .get();
    final userdata =
        snapshot.docs.map((e) => TodoModel.fromSnapshot(e)).toList();
    return userdata;
  }

  Future<void> updateTask({userid, todoid, bool? valueUpdate}) async {
    try {
      await firestore
          .collection(userCollection)
          .doc(userid)
          .collection(todoCollection)
          .doc(todoid)
          .update({
        'isDone': valueUpdate,
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> deleteTask({userid, todoid}) async {
    try {
      firestore
          .collection(userCollection)
          .doc(userid)
          .collection(todoCollection)
          .doc(todoid)
          .delete();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
