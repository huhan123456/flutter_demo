class HomeBannerList {
  List<HomeBannerData>? homeBannerList;
  HomeBannerList.fromJson(dynamic json) {
    homeBannerList = [];
    if(json is List){
      for (var i in json) {
        homeBannerList?.add(HomeBannerData.fromJson(i));
      }
    }
  }
}

class HomeBannerData {
  HomeBannerData({
      this.desc, 
      this.id, 
      this.imagePath, 
      this.isVisible, 
      this.order, 
      this.title, 
      this.type, 
      this.url,});

  HomeBannerData.fromJson(dynamic json) {
    desc = json['desc'];
    id = json['id'];
    imagePath = json['imagePath'];
    isVisible = json['isVisible'];
    order = json['order'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
  }
  String? desc;
  num? id;
  String? imagePath;
  num? isVisible;
  num? order;
  String? title;
  num? type;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['desc'] = desc;
    map['id'] = id;
    map['imagePath'] = imagePath;
    map['isVisible'] = isVisible;
    map['order'] = order;
    map['title'] = title;
    map['type'] = type;
    map['url'] = url;
    return map;
  }

}