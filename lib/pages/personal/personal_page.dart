import 'package:demo/pages/auth/login_page.dart';
import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PersonalPageState();
  }
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _header(context), //头像
            _settings(), // 设置
          ],
        ),
      ),
    );
  }
}

//头像
Widget _header(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    width: double.infinity,
    height: 200,
    color: Colors.blue,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Image.asset(
              'assets/images/未登录头像.jpg',
              width: 60,
              height: 60,
            ),
          ),
          //跳转到登录页面
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
          },
        ),
        SizedBox(height: 2),
        GestureDetector(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Text(
              '未登录',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          //跳转到登录页面
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
          },
        ),
      ],
    ),
  );
}

//设置
Widget _settings() {
  return Container(
    width: double.infinity,
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: ListTile(
            title: Text('我的收藏'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 添加点击事件
            },
          ),
        ),
        Divider(height: 1),
        ListTile(
          title: Text('检查更新'),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            // TODO: 添加点击事件
          },
        ),
        Divider(height: 1),
        ListTile(
          title: Text('关于我们'),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            // TODO: 添加点击事件
          },
        ),
        Divider(height: 1),
      ],
    ),
  );
}
