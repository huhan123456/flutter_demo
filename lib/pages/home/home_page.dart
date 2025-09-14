import 'package:demo/pages/home/home_vm.dart';
import 'package:demo/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../repository/datas/home_list_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  HomeViewModel viewModel = HomeViewModel();
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    viewModel.getBanner();
    viewModel.getDocList(false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        body: SafeArea(
          child: SmartRefresher(
            controller: refreshController,
            enablePullUp: true,//开启支持上拉
            enablePullDown: true,//开启支持下拉
            header: ClassicHeader(),//上拉样式
            footer: ClassicFooter(),//下拉样式
            onLoading: () async {//上拉加载回调
              await viewModel.getDocList(true);
              refreshController.loadComplete();
            },
            onRefresh:  () async {//下拉刷新回调
              await viewModel.getBanner();
              await viewModel.getDocList(false);
              refreshController.refreshCompleted();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //轮播图
                  _banner(),
                  //内容区
                  _listView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // banner区域
  Widget _banner() {
    return Consumer<HomeViewModel>(
      builder: (context, vm, child) {
        return Container(
          margin: EdgeInsets.only(bottom: 5),
          width: double.infinity,
          height: 180,
          child: Swiper(
            itemCount: vm.bannerList.length ?? 0,
            indicatorLayout: PageIndicatorLayout.COLOR,
            autoplay: true,
            pagination: const SwiperPagination(),
            control: const SwiperControl(),
            itemBuilder: (context, index) {
              return Container(
                height: 150,
                color: Colors.lightBlue,
                child: Image.network(
                  vm.bannerList[index].imagePath ?? '',
                  fit: BoxFit.fill, //图片填满容器
                ),
              );
            },
          ),
        );
      },
    );
  }

  //内容区
  Widget _listView() {
    return Consumer<HomeViewModel>(
      builder: (context, vm, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _listItemView(viewModel.docList[index]);
          },
          itemCount: viewModel.docList.length,
        );
      },
    );
  }

  //内容区每一个item
  Widget _listItemView(HomeListItem? item) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 0.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(10), // 添加内边距
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 左对齐
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 15, // 半径，因为直径=30
                backgroundImage: NetworkImage(
                  'https://qcloud.dpfile.com/pc/AKcM2pAVOtPOKx2IR5L6gbHG54kWt5tIugorO9Y0T0keT-Jn-eHwbyZU8rCdj2Tp.jpg',
                ),
              ),
              SizedBox(width: 10),
              Text(item?.shareUser ?? ''),
              Spacer(),
              Text(item?.niceShareDate ?? ''),
              SizedBox(width: 10),
              Text(
                '置顶',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                RoutePath.webViewPage,
                arguments: {'title': '路由传参'},
              );
            },
            child: Text(item?.title ?? ''),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(item?.chapterName ?? '', style: TextStyle(color: Colors.green)),
              Spacer(),
              Image.asset('assets/images/柴犬.png', width: 30, height: 30),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
