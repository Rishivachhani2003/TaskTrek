import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:to_do_riverpod/controller/auth_repository.dart';
import 'package:to_do_riverpod/controller/sign_controller.dart';
import 'package:to_do_riverpod/controller/user_repository.dart';
import 'package:to_do_riverpod/model/usermodel.dart';
import 'package:to_do_riverpod/services/local_notification.dart';
import 'package:to_do_riverpod/view/home_page.dart';
import 'package:to_do_riverpod/view/login_view.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final controller = Get.put(SignupController());
  final userRepo = Get.put(UserRepository());
  final authRepo = Get.put(AuthenticationRepository());
  bool _showPassword = false;
  bool _showrePassword = false;

  @override
  void initState() {
    super.initState();
    LocalNotification.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                "Register to TaskTrek",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: controller.name,
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
                  label: const Text("Name"),
                  labelStyle: const TextStyle(color: Colors.black),
                  hintText: "Enter your Name",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(
                    Icons.person,
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
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: InputBorder.none,
                  label: Text("Password"),
                  labelStyle: TextStyle(color: Colors.black),
                  hintText: "Enter your Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.grey,
                  ),
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
                height: 20,
              ),
              TextField(
                controller: controller.repassword,
                obscureText: !_showrePassword,
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
                  label: const Text("Retype Password"),
                  labelStyle: const TextStyle(color: Colors.black),
                  hintText: "Enter your Retype Password",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.lock,
                      color: Colors.grey), // Add prefix icon
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _showrePassword = !_showrePassword;
                      });
                    },
                    icon: Icon(
                        _showrePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
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
                    final name = controller.name;
                    final email = controller.email;
                    final repass = controller.repassword;
                    final pass = controller.password;

                    if (name.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please Enter name");
                    } else if (email.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please Enter Email");
                    } else if (!email.text.isEmail) {
                      Fluttertoast.showToast(msg: "Enter Valid Email");
                    } else if (pass.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please Enter Password");
                    } else if (pass.text.length < 6) {
                      Fluttertoast.showToast(
                          msg: "Password length is greater than 6");
                    } else if (repass.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Please Enter Repeat Password");
                    } else if (repass.text.length < 6) {
                      Fluttertoast.showToast(
                          msg: "Password length is greater than 6");
                    } else if (pass.text != repass.text) {
                      Fluttertoast.showToast(msg: "Password is not match");
                    } else {
                      final user = UserModel(
                        name: name.text.trim(),
                        email: email.text.trim(),
                        password: pass.text.trim(),
                      );

                      Future<bool> isEmail =
                          controller.checkIfEmailInUse(email.text);
                      if (await isEmail) {
                        Fluttertoast.showToast(msg: "Email Already in Use");
                      } else {
                        await authRepo.signup(email.text, pass.text);
                        await userRepo.createUser(user);
                        Future.delayed(const Duration(seconds: 2));
                        Fluttertoast.showToast(msg: "Account Created");
                        LocalNotification.showNotification(
                          title: "TaskTrek",
                          body: "Welcome, in TaskTrek",
                        );
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => MyHomePage()));
                        name.clear();
                        email.clear();
                        pass.clear();
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const LoginView()));
                },
                child: const Text(
                  'Already registered? Login Here!',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
