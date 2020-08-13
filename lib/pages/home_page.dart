
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttershow/manager/home_data_manager.dart';
import 'package:fluttershow/module/common_model.dart';
import 'package:fluttershow/module/grid_nav_model.dart';
import 'package:fluttershow/module/home_model.dart';
import 'package:fluttershow/module/sales_box_model.dart';
import 'package:fluttershow/pages/search_page.dart';
import 'package:fluttershow/redux/app_starte.dart';
import 'package:fluttershow/weights/grid_nav.dart';
import 'package:fluttershow/weights/loading_container.dart';
import 'package:fluttershow/weights/local_nav.dart';
import 'package:fluttershow/weights/scales_box.dart';
import 'package:fluttershow/weights/search_bar.dart';

const KSearch_Bar_Default_Text="哪里去玩 美食 酒店 打卡";
const KAppBar_Scroll_offest=100;
List<CommonModel> bannerList =[];
class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      return _HomePageSate();
  }
}

class _HomePageSate extends State<HomePage> {
  List<String> _imageUrlList = [
    "http://p1.music.126.net/yC_df5u0myXVp-bM99K3Lw==/5870292580832850.jpg",
    "http://p1.music.126.net/yC_df5u0myXVp-bM99K3Lw==/5870292580832850.jpg",
    "http://p1.music.126.net/yC_df5u0myXVp-bM99K3Lw==/5870292580832850.jpg",
  ];
  double appBarAlpha = 0;
  String resultString = "";

  //todo 首页需要的数据以及数据源
    HomeModel homeModel;
    GridNavModel gridNavModel;
    SalesBoxModel salesBoxModel;
    bool  _loading=true;
    List<CommonModel> localNavList =[];
    List<CommonModel> subNavList =[];



  _onScroll(offset) {
    print(offset);
    //得到一个透明度的值
    double alpha = offset / KAppBar_Scroll_offest;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    //给状态赋值
    setState(() {
      appBarAlpha = alpha;
    });
    print("透明度$appBarAlpha");
  }

  //todo 通过module获取数据
  Future<Null> _handleRefresh() async {
    HomeModel myHomemodel=await HomeDataManager.fetch();
    try {
      setState(() {
        //todo 获取数据
        localNavList=myHomemodel.localNavList;
        gridNavModel=myHomemodel.gridNav;
        subNavList=myHomemodel.subNavList;
        salesBoxModel=myHomemodel.salesBox;
        bannerList=myHomemodel.bannerlist;
        _loading=false;
      });
    } catch (e) {
      setState(() {
        resultString = e.toString();
        _loading = false;
      });
    }
    return null;
  }
    @override
    void initState() {
      //todo 在这里拿数据
      _handleRefresh();
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return StoreBuilder<AppState>(
          builder: (context, store) {
            return Scaffold(
              backgroundColor: Colors.deepOrange,
              body:LoadingContainer(
               child: Stack(
                  children: <Widget>[
                    MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: RefreshIndicator(
                          child: NotificationListener(
                            //滑动的监听
                            onNotification: (scrollNotification) {
                              //滑动的时候开始监听&&第0个元素移动的时候监听
                              if (scrollNotification is ScrollUpdateNotification &&
                                  scrollNotification.depth == 0) {
                                _onScroll(scrollNotification.metrics.pixels);
                              }
                            },
                            child: _listView,

                          ),
                          onRefresh: _handleRefresh //刷新
                      ),
                    ),
                    _appBar,
                  ],
                ),
                isLoading: _loading,
              )
            );
            //todo isLoading
          }
      );
    }
    Widget get _listView{
          //列表
          return ListView(
              children: <Widget>[
                _banner,
                //间隔
                Padding(
                  padding: const EdgeInsets.fromLTRB(7, 5, 7, 5),
                  //圆形的列表
                  child: LocalNav(localNavList: localNavList,),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(7, 0, 7, 5),
                  //卡片布局
                  child: GridNav(gridNavModel:gridNavModel),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(7, 0, 7, 5),
                  //活动相关
                  child: SalesBox(salesBoxModel: salesBoxModel,),
                ),
              ],
          );
    }
    Widget get _appBar{
      return Column(
        children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0x66000000),Colors.amberAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,

                ),
              ),

             child: Container(
                  padding: EdgeInsets.fromLTRB(2, 20, 2, 2),
                  height: 80,
                  decoration: BoxDecoration(
                    //没有a的时候图片都是方的
                    color: Color.fromARGB((appBarAlpha*255).toInt(),255,255,255)
                  ),
              //todo 搜索的BAR
              child:  SearchBar(
                  searchBarType: appBarAlpha>0.2?
                  SearchBarType.homeLight:
                      SearchBarType.home,
                defaultText: KSearch_Bar_Default_Text,
                //左边的点击事件
                leftButtonClick:(){

                } ,

              ),

             ),
            ),
          Container(
              height: appBarAlpha>0.2?0.5:0,
              decoration: BoxDecoration(
                boxShadow:[BoxShadow(color: Colors.black12,blurRadius: 0.5)],
              ),
            ),
        ],
      );
    }
}
//banner
Widget get _banner{
    return Container(
        height: 100,
      child: Swiper(
        //todo bannerList
            itemCount:bannerList.length,
            autoplay: true,
            itemBuilder: (BuildContext context,int index){
                return GestureDetector(
                    child: Image.network(
                      bannerList[index].icon,
                      fit: BoxFit.fill,
                    ),
                  onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          //todo 位置跳转页面
                      ));
                  },
               );
            },
        pagination:SwiperPagination(),
      ),
    );
}
// _jumpToSearch(BuildContext context){
//    Navigator.push(
//        context,
//        MaterialPageRoute(builder:
//    (context){
//        return SearchPage();
//    }
//      )
//    );
//}
// _jumpToSpreak(BuildContext context){
//  Navigator.push(
//    //todo 判断isIOS
//      context,
//      MaterialPageRoute(builder:
//      (context){
//    return SpeakPage();
//  }
//  )
//  );
//}