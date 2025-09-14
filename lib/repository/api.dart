import 'package:demo/repository/datas/common_website_data.dart';
import 'package:demo/repository/datas/home_list_data.dart';
import 'package:dio/dio.dart';

import '../http/dio_utils.dart';
import 'datas/home_banner_data.dart';
import 'datas/search_hot_key_data.dart';

class Api {
  static Api instance = Api._();
  Api._();

  //获取首页banner列表
  Future<List<HomeBannerData>> getBanner() async {
    Response response = await DioUtils().get('banner/json');
    HomeBannerList homeBannerDataList = HomeBannerList.fromJson(response.data);
    return homeBannerDataList.homeBannerList ?? [];
  }

  //获取首页文章列表
  Future<HomeListData> getDocList(num page) async {
    Response response = await DioUtils().get('article/list/$page/json');
    HomeListData homeListData = HomeListData.fromJson(response.data);
    return homeListData;
  }

  //获取常用网站
  Future<CommonWebsiteDataList> getWebsiteList() async {
    Response response = await DioUtils().get('friend/json');
    CommonWebsiteDataList websiteDataList= CommonWebsiteDataList.fromJson(response.data);
    return websiteDataList;
  }

  //获取搜索热点
  Future<SearchHotKeyDataList> getSearchHotKey() async {
    Response response = await DioUtils().get('hotkey/json');
    SearchHotKeyDataList searchHotKeyDataList= SearchHotKeyDataList.fromJson(response.data);
    return searchHotKeyDataList;
  }
}