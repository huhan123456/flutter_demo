import 'package:demo/pages/auth/login_page.dart';
import 'package:demo/pages/auth/register_page.dart';
import 'package:demo/pages/tab_page.dart';
import 'package:demo/pages/web_view_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.tab:
        return pageRoute(TabPage(),settings: settings);
      case RoutePath.webViewPage:
        return pageRoute(WebViewPage(),settings: settings);
      case RoutePath.loginPage:
        return pageRoute(LoginPage(),settings: settings);
      case RoutePath.registerPage:
        return pageRoute(RegisterPage(),settings: settings);
    }
    return pageRoute(Scaffold(body: Center(child: Text('404 Not Fount'))));
  }

  static MaterialPageRoute pageRoute(
    Widget page, {
    RouteSettings? settings,
    bool? fullscreenDialog,
    bool? maintainState,
    bool? allowSnapshotting,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return page;
      },
      settings: settings,
      fullscreenDialog: fullscreenDialog ?? false,
      maintainState: maintainState ?? true,
      allowSnapshotting: allowSnapshotting ?? true,
    );
  }
}

class RoutePath {
  static const String tab = '/'; //首页
  static const String webViewPage = '/web_view_page';
  static const String loginPage = '/login_page';//登录页面
  static const String registerPage = '/register_page';//登录页面
}
