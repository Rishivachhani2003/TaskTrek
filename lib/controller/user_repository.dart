import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:to_do_riverpod/constants/firebase_consts.dart';
import 'package:to_do_riverpod/model/usermodel.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  createUser(UserModel user) async {
    try {
      await firestore.collection(userCollection).add(user.toJson());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot = await firestore
        .collection(userCollection)
        .where("email", isEqualTo: email)
        .get();
    final userdata = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userdata;
  }
}
