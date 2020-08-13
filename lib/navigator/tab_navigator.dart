import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttershow/pages/home_drawer.dart';
import 'package:fluttershow/pages/home_page.dart';
import 'package:fluttershow/pages/my_page.dart';
import 'package:fluttershow/pages/search_page.dart';
import 'package:fluttershow/pages/travel_page.dart';
import 'package:fluttershow/redux/app_starte.dart';

class TabHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      return _TabState();
  }

}
class _TabState extends State{

  // 默认状态的颜色
    final Color _defalutColor=Colors.grey;
    //选中状态的颜色
    final Color _activieColor=Colors.indigo;
    //选中的索引对应页面
    int _currentIndex=0;

     //管理页面的controller
    final PageController _controller=PageController(
      //初始页面
      initialPage: 0
    );
  @override
  Widget build(BuildContext context) {
      return StoreBuilder<AppState>(
       builder: (context,store){
           return Scaffold(
              body: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _controller,
                children: <Widget>[
            //todo 必须根据类内部的class名称找到对应的类名
                  HomePage(),
                  SearchPage(),
                  TravelPage(),
                  Mypage(),
                ],
              ),
            drawer :HomeDrawer(),

             bottomNavigationBar: BottomNavigationBar(
              backgroundColor: store.state.themeData.primaryColor,
              currentIndex: _currentIndex,
              onTap: (index){
                  setState(() {
                      //跳转到相应的页面
                    _controller.jumpToPage(index);
                    _currentIndex=index;
                  });
              },
               type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home,color: _defalutColor,),
                    activeIcon: Icon(Icons.home,color: _activieColor,),
                    title: Text("主页",
                      style: TextStyle(
                          color: _currentIndex!=0?_defalutColor:_activieColor,
                      ),
                    )
                  ),

                  BottomNavigationBarItem(
                      icon: Icon(Icons.search,color: _defalutColor,),
                      activeIcon: Icon(Icons.search,color: _activieColor,),
                      title: Text("搜索",
                        style: TextStyle(
                          color: _currentIndex!=1?_defalutColor:_activieColor,
                        ),
                      )
                  ),

                  BottomNavigationBarItem(
                      icon: Icon(Icons.camera_alt,color: _defalutColor,),
                      activeIcon: Icon(Icons.camera_alt,color: _activieColor,),
                      title: Text("拍照",
                        style: TextStyle(
                          color: _currentIndex!=2?_defalutColor:_activieColor,
                        ),
                      )
                  ),

                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle,color: _defalutColor,),
                      activeIcon: Icon(Icons.account_circle,color: _activieColor,),
                      title: Text("我的",
                        style: TextStyle(
                          color: _currentIndex!=3?_defalutColor:_activieColor,
                        ),
                      )
                  ),

                ],
             ),


           );
       }

       );
  }

}