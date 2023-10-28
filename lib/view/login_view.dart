import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:to_do_riverpod/controller/auth_repository.dart';
import 'package:to_do_riverpod/controller/login_controller.dart';
import 'package:to_do_riverpod/view/home_page.dart';
import 'package:to_do_riverpod/view/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _showPassword = false;
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Welcome to the Notes App",
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
                height: 20,
              ),
              TextField(
                controller: controller.password,
                obscureText: !_showPassword,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  border: InputBorder.none,
                  label: const Text("Password"),
                  labelStyle: const TextStyle(color: Colors.black),
                  hintText: "Enter your Password",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon:
                      const Icon(Icons.lock, color: Colors.grey), // Add prefix icon
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    icon: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black),
                  ),

                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: TextButton(
                  onPressed: () async {
                    final email = controller.email;
                    final pass = controller.password;

                    if (email.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please Enter Email");
                    } else if (!email.text.isEmail) {
                      Fluttertoast.showToast(msg: "Enter Valid Email");
                    } else if (pass.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please Enter Password");
                    } else if (pass.text.length < 6) {
                      Fluttertoast.showToast(
                          msg: "Password length is greater than 6");
                    } else {
                      Future<bool> isEmail =
                          controller.checkIfEmailInUse(email.text);
                      if (await isEmail) {
                        Future<bool> isPass = authrepo.login(
                          email.text,
                          pass.text,
                        );
                        if (await isPass) {
                          Future.delayed(const Duration(seconds: 2));
                          Fluttertoast.showToast(msg: "Login Successfully");
                          // ignore: use_build_context_synchronously
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) => MyHomePage()));
                          email.clear();
                          pass.clear();
                        } else {
                          Fluttertoast.showToast(msg: "Password is wrong");
                        }
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
                      'Login', // Add the text "Login"
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
              Center(
                  child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const RegisterView()));
                },
                child: const Text(
                  'Not registered yet? Register Here!',
                  style: TextStyle(color: Colors.black),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
