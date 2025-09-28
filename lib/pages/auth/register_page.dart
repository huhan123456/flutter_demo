import 'package:bot_toast/bot_toast.dart';
import 'package:demo/pages/auth/auth_vm.dart';
import 'package:demo/pages/auth/login_page.dart';
import 'package:demo/repository/datas/register_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//注册页面
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
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
                    const SizedBox(height: 15),
                    //密码确认
                    _passwordAgainInput(vm),
                    const SizedBox(height: 30),
                    //点击注册
                    _register(vm,context),
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
    onChanged: (value) {
      vm.registerInfo.username = value;
    },
  );
}

//密码输入框
Widget _passwordInput(AuthViewModel vm) {
  return TextField(
    obscureText: true,
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
    onChanged: (value) {
      vm.registerInfo.password = value;
    },
  );
}

//密码确认框
Widget _passwordAgainInput(AuthViewModel vm) {
  return TextField(
    obscureText: true,
    decoration: InputDecoration(
      hintText: '再次输入密码',
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
    onChanged: (value) {
      vm.registerInfo.rePassword = value;
    },
  );
}

//注册按钮
Widget _register(AuthViewModel vm,context) {
  return SizedBox(
    width: 240,
    height: 40,
    child: OutlinedButton(
      onPressed: () async {
        if (vm.registerInfo.username == null ||
            vm.registerInfo.password == null ||
            vm.registerInfo.rePassword == null) {
          BotToast.showText(text: '用户名或密码不能为空');
        }
        // 注册
        RegisterData registerData = await vm.register();
        if(registerData.id != null){
          BotToast.showText(text: '注册成功');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
        }
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: const Text('点击注册', style: TextStyle(color: Colors.white)),
    ),
  );
}
