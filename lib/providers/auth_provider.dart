import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _email = '';
  String _password = '';
  String _username = '';
  String _avatar = '';

  String get email => _email;
  String get password => _password;
  String get username => _username;
  String get avatar => _avatar;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setAvatar(String avatar) {
    _avatar = avatar;
    notifyListeners();
  }

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void logout(){
    _email = "";
    _password = "";
    _avatar = "";
    _username = "";
    notifyListeners();
  }

}
