import 'package:app_with_local_database/components/CustomButton.dart';
import 'package:app_with_local_database/components/CustomInputField.dart';
import 'package:app_with_local_database/components/PasswordField.dart';
import 'package:app_with_local_database/constants/constant.dart';
import 'package:app_with_local_database/dashboard.dart';
import 'package:app_with_local_database/db/_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:random_string/random_string.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String authToken = randomAlphaNumeric(20);
  void login() async {
    EasyLoading.show(status: "Logging in ....");
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    Map<String, dynamic>? user =
        await DatabaseHelper().getUserByUsernameAndPassword(username, password);

    if (user != null) {
      // Login successful, navigate to another screen or perform other actions

      EasyLoading.showSuccess('Login successful! User: ${user['username']}');
      Get.offAll(() => Dashboard());
    } else {
      // Invalid login, display error message

      EasyLoading.showError('Invalid username or password.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("Login Screen"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomButton(
              title: "Login",
              onTap: () {
                login();
              },
              color: mainColor),
          SizedBox(
            height: 12,
          ),
          CustomButton(
              title: "Register", onTap: () {}, color: Colors.grey.shade300)
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
          PasswordField(
              label: "Enter Password",
              controller: passwordController,
              obscure: true)
        ],
      ),
    );
  }
}
