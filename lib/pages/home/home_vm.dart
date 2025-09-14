import 'package:demo/datas/home_banner_data.dart';
import 'package:demo/datas/home_list_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../http/dio_utils.dart';

class HomeViewModel with ChangeNotifier {

  final dio = Dio();

  List<BannerItemData>? bannerList;
  List<HomeListItem>? docList;
  int page = 1;

  void initDio(){
    dio.options = BaseOptions(
      baseUrl: 'https://www.wanandroid.com/',
      method: 'get',
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      sendTimeout: Duration(seconds: 30),
    );
  }

  //获取首页banner列表
  Future getBanner() async {
    Response response = await DioUtils().get('banner/json');
    HomeBannerData homeBannerData = HomeBannerData.fromJson(response.data);
    if (homeBannerData.data != null) {
      bannerList = homeBannerData.data;
    } else {
      bannerList = [];
    }
    notifyListeners();
  }
  //获取首页文章列表
  Future getDocList(bool loadMore) async {
    if(loadMore){
      page++;
    }else{
      page = 1;
    }
    Response response = await DioUtils().get('article/list/$page/json');
    HomeListData homeListData = HomeListData.fromJson(response.data);
    if (homeListData.data != null && homeListData.data?.datas != null) {
      if(loadMore){
        docList?.addAll(homeListData.data?.datas ?? []);
      }else{
        docList = homeListData.data?.datas;
      }
    } else {
      docList = [];
    }
    notifyListeners();
  }

}
