import 'package:app_with_local_database/Authentication/login.dart';
import 'package:app_with_local_database/components/CustomButton.dart';
import 'package:app_with_local_database/components/CustomInputField.dart';
import 'package:app_with_local_database/components/PasswordField.dart';
import 'package:app_with_local_database/constants/constant.dart';
import 'package:app_with_local_database/dashboard.dart';
import 'package:app_with_local_database/db/_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  void registerUser(String username, String email, String password) {
    EasyLoading.show(status: "Creating account ....");
    DatabaseHelper().saveUser(username, email, password).then((value) {
      EasyLoading.dismiss();
      Get.to(() => Dashboard());
    }).onError((error, stackTrace) {
      EasyLoading.showError(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("Create Account Screen"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomButton(
            color: mainColor,
            onTap: () {
              if (usernameController.text.isEmpty ||
                  passwordController.text.isEmpty ||
                  emailController.text.isEmpty) {
                EasyLoading.showToast("Please Complete all details");
              } else {
                registerUser(usernameController.text, emailController.text,
                    passwordController.text);
              }
              // print(emailController.text);
            },
            title: "Register",
          ),
          SizedBox(
            height: 12,
          ),
          CustomButton(
              color: Colors.grey.shade300,
              title: "Login",
              onTap: () {
                Get.to(LoginScreen());
              })
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomInputField(
            label: "Username",
            controller: usernameController,
            icon: Icons.person,
          ),
          CustomInputField(
            label: "Email",
            controller: emailController,
            icon: Icons.email,
          ),
          PasswordField(
              label: "Enter Password",
              controller: passwordController,
              obscure: true)
        ],
      ),
    );
  }
}
