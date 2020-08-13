
import 'package:fluttershow/module/common_model.dart';
import 'package:fluttershow/module/sales_box_model.dart';

import 'config_model.dart';
import 'grid_nav_model.dart';
import 'common_model.dart';

class HomeModel{
  final ConfigModel config;
  /// banner
  final List<CommonModel> bannerlist;
  /// 导航
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SalesBoxModel salesBox;

  HomeModel({
    this.config,this.bannerlist,this.localNavList,
    this.subNavList,this.gridNav,this.salesBox
});
  factory HomeModel.fromJson(Map<String,dynamic>json){
    var localNavListJson=json["localNavList"] as List;
    List<CommonModel>localNavList=localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    var bannerListJson=json["bannerList"] as List;
    List<CommonModel> bannerlist=bannerListJson.map((i) => CommonModel.fromJson(i)).toList();
    
    var subNavListJson=json["subNavList"] as List;
    List<CommonModel> subNavList=subNavListJson.map((i) => CommonModel.fromJson(i)).toList();
    return HomeModel(
      localNavList: localNavList,
      bannerlist: bannerlist,
      subNavList: subNavList,
      config: ConfigModel.fromJson(json["config"]),
      gridNav: GridNavModel.fromJson(json["gridNav"]),
      salesBox: SalesBoxModel.fromJson(json["salesBox"]),
    );
  }
}