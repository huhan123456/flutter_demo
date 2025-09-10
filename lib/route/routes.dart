import 'package:demo/pages/home/home_page.dart';
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
}
