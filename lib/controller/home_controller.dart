import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:to_do_riverpod/controller/auth_repository.dart';
import 'package:to_do_riverpod/controller/task_repository.dart';
import 'package:to_do_riverpod/controller/user_repository.dart';
import 'package:to_do_riverpod/model/todo_model.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final taskrepo = Get.put(TaskRepository());
  final userrepo = Get.put(UserRepository());
  final authrepo = Get.put(AuthenticationRepository());

  getUserData() {
    final email = authrepo.firebaseUser!.email;
    if (email != null) {
      return userrepo.getUserDetails(email);
    } else {
      Fluttertoast.showToast(msg: "Error");
    }
  }

  Future<List<TodoModel>> getTodoData({id}) async {
    final List<TodoModel> me = await taskrepo.getAllTodo(id: id);
    return me;
  }
}
