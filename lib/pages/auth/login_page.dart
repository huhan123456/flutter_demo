import 'package:demo/pages/auth/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//登录页面
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //账号
              _usernameInput(),
              const SizedBox(height: 15),
              //密码
              _passwordInput(),
              const SizedBox(height: 30),
              //点击登录
              _login(),
              const SizedBox(height: 15),
              //点击注册
              _register(context),
            ],
          ),
        ),
      ),
    );
  }
}

//账号输入框
Widget _usernameInput() {
  return TextField(
    decoration: InputDecoration(
      hintText: '输入账号',
      hintStyle: TextStyle(color: Colors.white70),
      labelText: '输入账号',
      labelStyle: TextStyle(color:Colors.white),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(6),
      ),
    ),
    style: TextStyle(color: Colors.white),//设置输入的字体颜色
    cursorColor: Colors.white,//设置光标颜色
  );
}

//密码输入框
Widget _passwordInput() {
  return TextField(
    obscureText: true,
    decoration: InputDecoration(
      hintText: '输入密码',
      hintStyle: TextStyle(color: Colors.white70),
      labelText: '输入密码',
      labelStyle: TextStyle(color:Colors.white),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(6),
      ),
    ),
    style: TextStyle(color: Colors.white),//设置输入的字体颜色
    cursorColor: Colors.white,//设置光标颜色
  );
}

//登录按钮
Widget _login() {
  return SizedBox(
    width: double.infinity,
    height: 40,
    child: OutlinedButton(
      onPressed: () {
        //点击登录
        
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
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => RegisterPage(),
      ));
    },
    child: const Text('注册', style: TextStyle(color: Colors.white)),
  );
}
