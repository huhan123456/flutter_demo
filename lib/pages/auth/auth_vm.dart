import 'package:demo/repository/datas/register_data.dart';
import 'package:flutter/cupertino.dart';

import '../../repository/api.dart';

class AuthViewModel with ChangeNotifier {

  RegisterInfo registerInfo = RegisterInfo();
  LoginInfo loginInfo = LoginInfo();

  //登录
  Future login(username, password) async {
    var searchHotKeyDataList = await Api.instance.login(registerInfo.username, registerInfo.password);
    notifyListeners();
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