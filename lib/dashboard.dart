import 'dart:async';

import 'package:app_with_local_database/components/CustomButton.dart';
import 'package:app_with_local_database/components/CustomDropdown.dart';
import 'package:app_with_local_database/components/CustomInputField.dart';
import 'package:app_with_local_database/components/PasswordField.dart';
import 'package:app_with_local_database/constants/constant.dart';
import 'package:app_with_local_database/db/_database.dart';
import 'package:app_with_local_database/model/user_model.dart';
import 'package:app_with_local_database/views/projects.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> items = ["Manager", "QA", "Developer"];
  StreamController<double> controller = StreamController<double>();

  late Stream stream;
  final db = DatabaseHelper();
  final User user = User();
  final nameCon = TextEditingController();
  final emaiCon = TextEditingController();
  // final roleCon = TextEditingController();
  final phoneCon = TextEditingController();
  final passCon = TextEditingController();
  var selectedVal;
  Stream<List<User>>? userList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedVal = items[0];
    stream = controller.stream;
  }

  @override
  Widget build(BuildContext context) {
    String authToken = randomAlphaNumeric(20);
    return Scaffold(
      drawer: Drawer(
        child: Column(children: [
          SizedBox(
            height: 80,
          ),
          ListTile(
            leading: CircleAvatar(),
            title: Text(user.name.toString()),
            subtitle: Text(user.email.toString()),
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            onTap: () {
              Get.to(() => Projects());
            },
            title: Text("Projects"),
          ),
          ListTile(
            onTap: () {},
            title: Text("Bugs"),
          ),
          ListTile(
            onTap: () {
              DatabaseHelper().deleteDatabaseExample();
            },
            title: Text("Logout"),
          )
        ]),
      ),
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Column(
        children: [
          Text("Create New User"),
          Form(
              child: Column(
            children: [
              Row(
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
                        user.role = value.toString();
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
              CustomInputField(
                label: "Name",
                controller: nameCon,
                icon: Icons.person,
              ),
              CustomInputField(
                label: "Email",
                controller: emaiCon,
                icon: Icons.email,
              ),
              CustomInputField(
                label: "Phone",
                controller: phoneCon,
                icon: Icons.phone,
              ),
              PasswordField(
                  label: "Enter Password", controller: passCon, obscure: true),
              CustomButton(
                  title: "Save User",
                  onTap: () {
                    EasyLoading.show(status: 'Saving...');
                    user.name = nameCon.text.trim();
                    user.email = emaiCon.text.trim();
                    user.phone = phoneCon.text.trim();
                    user.role = nameCon.text.trim();
                    user.password = passCon.text.trim();

                    print(user.role);
                    db.insertUser(user).then((value) {
                      EasyLoading.showSuccess("User added successfully");
                      setState(() {});
                    }).onError((error, stackTrace) {
                      EasyLoading.showError(error.toString());
                    });
                  },
                  color: Colors.green),
              SizedBox(
                height: 10,
              ),
              Text("Available Users"),
              Container(
                height: 300,
                color: lightBg,
                child: StreamBuilder<List<User>>(
                  stream: db.getUsersStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No users found'));
                    }

                    // Data is available, build your UI with the snapshot.data
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final user = snapshot.data![index];
                        return ListTile(
                          title: Text(user.name.toString()),
                          subtitle: Text(user.email.toString()),
                          // Add more details or customize as needed
                        );
                      },
                    );
                  },
                ),

                // child: ,
              )
            ],
          ))

          // Text(authToken),
          // ListTile(
          //   title: Text(User().username.toString()),
          // )
        ],
      ),
      floatingActionButton: CustomButton(
        title: "Get user Data",
        onTap: () {
          // DatabaseHelper()
          //     .getUserData(
          //   'dev',
          // )
          //     .then((value) async {
          //   await SharedPreferences.getInstance().then((val) {
          //     print(
          //         "Stored Token in shared preferences  : ${val.getString('token')}");
          //   });
          // });
        },
        color: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
