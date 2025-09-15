import 'package:flutter/material.dart';

class WebViewPage extends StatefulWidget {

  final String? title;
  final String? url;
  const WebViewPage({super.key,this.title,this.url});

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  String name = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      var map = ModalRoute.of(context)?.settings.arguments;
      if(map is Map){
        name = map['name'];
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //接受路由参数
    return Scaffold(
       appBar: AppBar(title:Text(name)),
        body: SafeArea(child: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Text('返回上级'),
        )));
  }
}
