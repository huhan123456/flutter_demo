import 'package:demo/pages/hot_key/hot_key_vm.dart';
import 'package:demo/pages/web_view_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HotKeyPage extends StatefulWidget {
  const HotKeyPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HotKeyPageState();
  }
}

class _HotKeyPageState extends State<HotKeyPage> {


  HotKeyViewModel hotKeyViewModel = HotKeyViewModel();

  @override
  void initState() {
    super.initState();
    hotKeyViewModel.getHotKeyPageData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HotKeyViewModel>(//监听HotKeyViewModel
      create: (context) {
        return hotKeyViewModel;
      },
      child: Scaffold(
          body: SafeArea(
              child: SingleChildScrollView( //可滑动
                child: Expanded(
                    child: Column(children: [
                      _searchHotKeyInput(), //热点搜索Input框
                      _hotKeyList(),//热点网格
                      _websiteInput(),//热点网站标题
                      _websiteList(),//热点网站网格
                    ],)
                ),
              )
          )
      ),
    );
  }
}


//热点搜索Input框
Widget _searchHotKeyInput() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: '搜索热词',
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
        Icon(Icons.search, color: Colors.grey),
      ],
    ),
  );
}

//热点搜索网格
Widget _hotKeyList() {
  return Consumer<HotKeyViewModel>(
      builder: (context, vm, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,// 每行4个
            mainAxisSpacing: 8,// 行间距8px
            crossAxisSpacing: 8,// 列间距8px
            childAspectRatio: 2.5, // 宽高比，调整按钮形状
            children: vm.hotKeyList.map((hotKeyItem) {
              return GestureDetector(
                onTap:(){

                },
                child: Container(
                  alignment: Alignment.center, // 内容居中（包括文字）
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),// 内边距
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    hotKeyItem.name ?? '',
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                    textAlign:TextAlign.center,
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }
  );
}

//热点网站标题
Widget _websiteInput() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: '常用网站',
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
        Icon(Icons.search, color: Colors.grey),
      ],
    ),
  );
}

//热点网站网格
Widget _websiteList() {
  return Consumer<HotKeyViewModel>(
      builder: (context, vm, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,// 每行4个
            mainAxisSpacing: 8,// 行间距8px
            crossAxisSpacing: 8,// 列间距8px
            childAspectRatio: 2.5, // 宽高比，调整按钮形状
            children: vm.websiteList.map((hotKeyItem) {
              return GestureDetector(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => WebViewPage(title: '常用网站'),
                  ));
                },
                child: Container(
                  alignment: Alignment.center, // 内容居中（包括文字）
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),// 内边距
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    hotKeyItem.name ?? '',
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                    textAlign:TextAlign.center,
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }
  );
}

