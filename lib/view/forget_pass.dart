import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:to_do_riverpod/controller/auth_repository.dart';
import 'package:to_do_riverpod/controller/login_controller.dart';
import 'package:to_do_riverpod/view/login_view.dart';

class ForgetPassView extends StatefulWidget {
  const ForgetPassView({Key? key}) : super(key: key);

  @override
  State<ForgetPassView> createState() => _ForgetPassViewState();
}

class _ForgetPassViewState extends State<ForgetPassView> {
  final controller = Get.put(LoginController());
  final authrepo = Get.put(AuthenticationRepository());

  checkNetwork() async {
    bool result = await InternetConnectionChecker().hasConnection;

    if (mounted && result == false) {
      Fluttertoast.showToast(msg: 'No Internet Connection');
    } else {
      Fluttertoast.showToast(msg: 'Internet Connection Normal');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 500,
                    width: MediaQuery.of(context).size.width - 100,
                    decoration: const BoxDecoration(),
                    child: Image.asset(
                      "assets/images/launcher_icon.png",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Reset Password",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: controller.email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.blueGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    border: InputBorder.none,
                    label: const Text("Email"),
                    labelStyle: const TextStyle(color: Colors.black),
                    hintText: "Enter your Email",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: TextButton(
                    onPressed: () async {
                      final email = controller.email;
                      if (email.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Please Enter Email");
                      } else if (!email.text.isEmail) {
                        Fluttertoast.showToast(msg: "Enter Valid Email");
                      } else {
                        Future<bool> isEmail =
                            controller.checkIfEmailInUse(email.text);
                        if (await isEmail) {
                          await authrepo.passwordReset(email.text);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) => const LoginView()));
                        } else {
                          Fluttertoast.showToast(msg: "Email is not exists");
                        }
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Make the button circular
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.black), // Set background color to blue
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(
                          0.0), // Add some padding for better visibility
                      child: Text(
                        'Send Email', // Add the text "Login"
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
