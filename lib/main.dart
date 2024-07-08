import 'package:app_with_local_database/Authentication/login.dart';
import 'package:app_with_local_database/Authentication/signup.dart';
import 'package:app_with_local_database/dashboard.dart';
import 'package:app_with_local_database/db/_database.dart';
import 'package:app_with_local_database/views/databaseScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sp = await SharedPreferences.getInstance();
  await DatabaseHelper().initDb();
  await DatabaseHelper().initDatabase();
  runApp(const MyApp());
}

late SharedPreferences sp;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DatabaseTable(),
    );
  }
}
