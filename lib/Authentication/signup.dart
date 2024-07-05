import 'package:app_with_local_database/Authentication/login.dart';
import 'package:app_with_local_database/components/CustomButton.dart';
import 'package:app_with_local_database/components/CustomDropdown.dart';
import 'package:app_with_local_database/components/CustomInputField.dart';
import 'package:app_with_local_database/components/PasswordField.dart';
import 'package:app_with_local_database/constants/constant.dart';
import 'package:app_with_local_database/dashboard.dart';
import 'package:app_with_local_database/db/_database.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
  List<String> items = ["Manager", "QA", "Developer"];
  // void registerUser(String username, String email, String password, role) {
  //   EasyLoading.show(status: "Creating account ....");
  //   DatabaseHelper().saveUser(username, email, password, role).then((value) {
  //     EasyLoading.dismiss();
  //     Get.to(() => Dashboard());
  //   }).onError((error, stackTrace) {
  //     EasyLoading.showError(error.toString());
  //   });
  // }

  var selectedVal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
    var selectedVal = items[0];
  }

  var role;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("Create Account Screen"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DropdownButtonHideUnderline(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Role",
                  style: TextStyle(fontSize: 18),
                ),
                DropdownButton2<String>(
                  isExpanded: true,
                  hint: const Row(
                    children: [
                      Icon(
                        Icons.list,
                        size: 16,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          'Select Item',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: items
                      .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: selectedVal,
                  onChanged: (String? value) {
                    setState(() {
                      selectedVal = value!;
                      role = value.toString();
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    height: 30,
                    width: 160,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      color: mainColor,
                    ),
                    elevation: 2,
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                    iconSize: 14,
                    iconEnabledColor: Colors.white,
                    iconDisabledColor: Colors.grey,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: mainColor,
                    ),
                    offset: const Offset(-20, 0),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 30,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ],
            ),
          )),
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
                // registerUser(usernameController.text, emailController.text,
                //     passwordController.text, selectedVal);
                print(selectedVal);
              }
              // print(emailController.text);
            },
            title: "Register",
          ),
          TextButton(
              onPressed: () {
                // DatabaseHelper().deleteDatabaseFile();
              },
              child: Text("Delete Database")),
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
    );
  }
}
