////userstorage

import 'package:shared_preferences/shared_preferences.dart';

// ...

// This class is to save user info & credentials securely
class UserStorage {
  static UserStorage? inst;
  static const PHONE = "user.phone";
  static const EMAIL = "user.email";
  static const PWD = "user.pwd";
  static const NAME = "user.name";

  UserStorage._();

  factory UserStorage() {
    inst ??= UserStorage._();
    return inst!;
  }

  Future<String> getName() async {
    final prefs = await getSharedPrefs();
    final name = await prefs.getValue(NAME) ?? "";
    return name;
  }

 setName(String name) async {
   final prefs = await getSharedPrefs();
   await prefs.setValue(NAME, name);
 }

  Future<String> getPwd() async {
    final prefs = await getSharedPrefs();
    return await prefs.getValue(PWD) ?? "";
  }

  setPwd(String pwd) async {
    final prefs = await getSharedPrefs();
    await prefs.setValue(PWD, pwd);
  }

  Future<String> getEmail() async {
    final prefs = await getSharedPrefs();
    return await prefs.getValue(EMAIL) ?? "";
  }

  setEmail(String email) async {
    final prefs = await getSharedPrefs();
    await prefs.setValue(EMAIL, email);
  }

  setPhone(String phone) async {
    final prefs = await getSharedPrefs();
    await prefs.setValue(PHONE, phone);
  }

  Future<String> getPhone() async {
    final prefs = await getSharedPrefs();
    return await prefs.getValue(PHONE) ?? "";
  }

  Future<bool> isRegistered() async {
    final prefs = await getSharedPrefs();
    String email = await prefs.getValue(EMAIL) ?? "";
    return email.isNotEmpty;
  }

  Future<UserPreferences> getSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('first_run') ?? true) {
      prefs.setBool('first_run', false);
    }
    return UserPreferences(prefs);
  }

  Future<bool> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    if (!(prefs.getBool('first_run') ?? false)) {
      prefs.clear();
      prefs.setBool('first_run', true);
      return true;
    } else {
      prefs.clear();
    }
    return false;
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

class UserPreferences {
  final String _prefix = "demo";
  SharedPreferences impl;

  UserPreferences(this.impl);

  Future<dynamic> getValue(String key) async {
    return impl.get(_prefix + key);
  }

  Future setValue(String key, dynamic value) async {
    await impl.setString(_prefix + key, value);
  }
}
