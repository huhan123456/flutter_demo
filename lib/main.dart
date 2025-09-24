import 'package:bot_toast/bot_toast.dart';
import 'package:demo/route/routes.dart';
import 'package:flutter/material.dart';
import 'http/dio_utils.dart';

void main() {
  DioUtils().init(); // 初始化 Dio
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      onGenerateRoute: Routes.generateRoute,
      initialRoute: RoutePath.tab,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
    );
  }
}
