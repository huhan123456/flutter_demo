import 'package:demo/repository/api.dart';
import 'package:demo/repository/datas/home_banner_data.dart';
import 'package:demo/repository/datas/home_list_data.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {

  List<HomeBannerData> bannerList = [];
  HomeListData homeListData = HomeListData();
  List<HomeListItem> docList = [];
  int page = 1;

  //获取首页banner列表
  Future getBanner() async {
    List<HomeBannerData> data= await Api.instance.getBanner();
    bannerList = data;
    notifyListeners();
  }
  //获取首页文章列表
  Future getDocList(bool loadMore) async {
    if(loadMore){//上拉加载下一页
      page++;
    }else{//下拉刷新第一页
      page = 1;
    }
    homeListData = await Api.instance.getDocList(page);
    if (homeListData.datas != null) {
      if(loadMore){
        docList.addAll(homeListData.datas ?? []);
      }else{
        docList = homeListData.datas ?? [];
      }
    }
    notifyListeners();
  }

}
