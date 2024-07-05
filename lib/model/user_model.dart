import 'package:sqflite/sqflite.dart';

class User {
  int? id;
  String? userId;
  String? name;
  String? role;
  String? email;
  String? phone;
  String? password;
  String? token;

  User({
    this.id,
    this.userId,
    this.name,
    this.role,
    this.email,
    this.phone,
    this.password,
    this.token,
  });

  // Convert User object to Map object for database operations
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'userId': userId,
      'name': name,
      'role': role,
      'email': email,
      'phone': phone,
      'password': password,
      'token': token,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Convert Map object from database to User object
  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    userId = map['userId'];
    name = map['name'];
    role = map['role'];
    email = map['email'];
    phone = map['phone'];
    password = map['password'];
    token = map['token'];
  }
}
