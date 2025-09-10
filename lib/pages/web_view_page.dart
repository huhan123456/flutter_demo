import 'package:flutter/material.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  String title = '';

  // @override
  // void initState() {
  //   super.initState();
  //   final args = ModalRoute.of(context)!.settings.arguments as Map;
  //   title = args["title"] as String;
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    title = args["title"] as String;
  }

  @override
  Widget build(BuildContext context) {
    //接受路由参数
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    title = args["title"] as String;

    return Scaffold(
       appBar: AppBar(title:Text(title)),
        body: SafeArea(child: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Text('返回上级'),
        )));
  }
}
