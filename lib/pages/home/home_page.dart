import 'package:demo/pages/home/home_vm.dart';
import 'package:demo/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';

import '../../datas/home_list_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.initDio();
    viewModel.getBanner();
    viewModel.getDocList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        body: SafeArea(
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
            itemCount: vm.bannerList?.length ?? 0,
            indicatorLayout: PageIndicatorLayout.COLOR,
            autoplay: true,
            pagination: const SwiperPagination(),
            control: const SwiperControl(),
            itemBuilder: (context, index) {
              return Container(
                height: 150,
                color: Colors.lightBlue,
                child: Image.network(
                  vm.bannerList?[index].imagePath ?? '',
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
            return _listItemView(viewModel.docList?[index]);
          },
          itemCount: viewModel.docList?.length ?? 0,
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
