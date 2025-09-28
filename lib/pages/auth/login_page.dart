import 'package:bot_toast/bot_toast.dart';
import 'package:demo/pages/auth/register_page.dart';
import 'package:demo/pages/tab_page.dart';
import 'package:demo/repository/datas/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_vm.dart';

//登录页面
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  AuthViewModel authViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00897B), // 近似截图的绿色
      appBar: AppBar(
        backgroundColor: const Color(0xFF00897B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ChangeNotifierProvider(
            create: (context) {
              return authViewModel;
            },
            child: Consumer<AuthViewModel>(
              builder: (context, vm, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //账号
                    _usernameInput(vm),
                    const SizedBox(height: 15),
                    //密码
                    _passwordInput(vm),
                    const SizedBox(height: 30),
                    //点击登录
                    _login(vm, context),
                    const SizedBox(height: 15),
                    //点击注册
                    _register(context),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

//账号输入框
Widget _usernameInput(AuthViewModel vm) {
  return TextField(
    decoration: InputDecoration(
      hintText: '输入账号',
      hintStyle: TextStyle(color: Colors.white70),
      labelText: '输入账号',
      labelStyle: TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(6),
      ),
    ),
    style: TextStyle(color: Colors.white), //设置输入的字体颜色
    cursorColor: Colors.white, //设置光标颜色
    onChanged: (value) => {vm.loginInfo.username = value},
  );
}

//密码输入框
Widget _passwordInput(AuthViewModel vm) {
  return TextField(
    obscureText: true,
    //密码框
    decoration: InputDecoration(
      hintText: '输入密码',
      hintStyle: TextStyle(color: Colors.white70),
      labelText: '输入密码',
      labelStyle: TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(6),
      ),
    ),
    style: TextStyle(color: Colors.white),
    //设置输入的字体颜色
    cursorColor: Colors.white,
    //设置光标颜色
    onChanged: (value) => {vm.loginInfo.password = value},
  );
}

//登录按钮
Widget _login(AuthViewModel vm, context) {
  return SizedBox(
    width: double.infinity,
    height: 40,
    child: OutlinedButton(
      onPressed: () async {
        //点击登录
        if (vm.loginInfo.username == null || vm.loginInfo.password == null) {
          BotToast.showText(text: '用户名或密码不能为空');
        }
        //登录
        UserData loginData = await vm.login(
          vm.loginInfo.username,
          vm.loginInfo.password,
        );
        if (loginData.id != null) {
          BotToast.showText(text: '登录成功');
          Navigator.pushAndRemoveUntil(
            //清空路由栈
            context,
            MaterialPageRoute(builder: (context) => TabPage()),
            (route) => false,
          );
        }
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: const Text('开始登录', style: TextStyle(color: Colors.white)),
    ),
  );
}

//注册按钮
Widget _register(context) {
  return TextButton(
    onPressed: () {
      // 跳转到注册页面
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterPage()),
      );
    },
    child: const Text('注册', style: TextStyle(color: Colors.white)),
  );
}
