import 'package:demo/pages/home/home_page.dart';
import 'package:demo/pages/hot_key/hot_key_page.dart';
import 'package:demo/pages/knowledge/knowledge_page.dart';
import 'package:demo/pages/personal/personal_page.dart';
import 'package:flutter/material.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabPageState();
  }
}

class _TabPageState extends State<TabPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: currentPageIndex,
          children: [HomePage(), HotKeyPage(), KnowledgePage(), PersonalPage()],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent,highlightColor: Colors.transparent),
        child: BottomNavigationBar(
          items: _barItemList(),
          onTap: (index) {
            currentPageIndex = index;
            setState(() {});
          },
          currentIndex: currentPageIndex,
          selectedItemColor: Colors.blue,    // 选中颜色
          unselectedItemColor: Colors.grey,  // 未选中颜色
          unselectedLabelStyle: TextStyle(color: Colors.black),
          selectedLabelStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _barItemList() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.person_outline, size: 28),
        activeIcon: Icon(Icons.person, size: 30),
        label: '首页',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.business_center_outlined, size: 28),
        activeIcon: Icon(Icons.business_center, size: 30),
        label: '热点',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.history_outlined, size: 28),
        activeIcon: Icon(Icons.history, size: 30),
        label: '333',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.history_outlined, size: 28),
        activeIcon: Icon(Icons.history, size: 30),
        label: '444',
      ),
    ];
  }
}
