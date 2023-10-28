import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:to_do_riverpod/controller/auth_repository.dart';
import 'package:to_do_riverpod/controller/user_repository.dart';

class ModelController extends GetxController {
  static ModelController get instance => Get.find();

  final _authrepo = Get.put(AuthenticationRepository());
  final _userrepo = Get.put(UserRepository());
  getUserData() {
    final email = _authrepo.firebaseUser!.email;
    if (email != null) {
      return _userrepo.getUserDetails(email);
    } else {
      Fluttertoast.showToast(msg: "Error");
    }
  }
}
