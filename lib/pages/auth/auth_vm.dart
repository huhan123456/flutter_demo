import 'package:demo/repository/datas/register_data.dart';
import 'package:demo/repository/datas/user_data.dart';
import 'package:flutter/cupertino.dart';

import '../../repository/api.dart';

class AuthViewModel with ChangeNotifier {

  RegisterInfo registerInfo = RegisterInfo();
  LoginInfo loginInfo = LoginInfo();

  //登录
  Future<UserData> login(username, password) async {
    UserData userData = await Api.instance.login(loginInfo.username, loginInfo.password);
    notifyListeners();
    return userData;
  }

  //注册
  Future<RegisterData> register() async {
    RegisterData registerData = await Api.instance.register(registerInfo.username, registerInfo.password, registerInfo.rePassword);
    notifyListeners();
    return registerData;
  }
}

class RegisterInfo{
  String? username;
  String? password;
  String? rePassword;
}

class LoginInfo{
  String? username;
  String? password;
}