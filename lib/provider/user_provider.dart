import 'package:flutter/material.dart';
import 'package:i_clone/models/user.dart';
import 'package:i_clone/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethod _authMethod = AuthMethod();
  User get getUser => _user!;
  Future<void> refreshUser() async {
    User user = await _authMethod.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
