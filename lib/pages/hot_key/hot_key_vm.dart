import 'package:flutter/widgets.dart';
import '../../repository/api.dart';
import '../../repository/datas/common_website_data.dart';
import '../../repository/datas/search_hot_key_data.dart';

class HotKeyViewModel with ChangeNotifier {

  List<CommonWebsiteData> websiteList = [];
  List<SearchHotKeyData> hotKeyList = [];

  //获取热点页面所有数据
  Future getHotKeyPageData() async{
    await getWebsite();//获取常用网站
    await getSearchHotKey();//获取搜索热点
    notifyListeners();
  }

  //获取常用网站
  Future getWebsite() async {
    CommonWebsiteDataList commonWebsiteData  = await Api.instance.getWebsiteList();
    websiteList = commonWebsiteData.websiteList;
  }

  //获取搜索热点
  Future getSearchHotKey() async {
    SearchHotKeyDataList searchHotKeyDataList  = await Api.instance.getSearchHotKey();
    hotKeyList = searchHotKeyDataList.searchHotKeyList;
  }

}