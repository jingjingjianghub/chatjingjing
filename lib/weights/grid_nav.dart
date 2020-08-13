import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:fluttershow/module/common_model.dart';
  import 'package:fluttershow/module/grid_nav_model.dart';
  import 'package:fluttershow/weights/webview.dart';

  class GridNav extends StatelessWidget{
  final GridNavModel gridNavModel;
  GridNav({Key key,@required this.gridNavModel}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.green,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
          children: _gridNavItems(context),
      ),
    );
  }
 _gridNavItems(BuildContext context){
      List<Widget> items=[];
      if(gridNavModel==null)return items;
      //酒店字段不为空
      if(gridNavModel.hotel!=null){
        items.add(_gridNavItem(context,gridNavModel.hotel,true));
      }
      //机票字段不为空
      if(gridNavModel.flight!=null){
        items.add(_gridNavItem(context,gridNavModel.flight,false));
      }
      //旅行字段不为空
      if(gridNavModel.travel!=null){
        items.add(_gridNavItem(context,gridNavModel.travel,false));
      }
      return items;
 }
  _gridNavItem(BuildContext context,GridItemModel gridItemModule,bool isFrist){
      List<Widget>items=[];
      items.add(_mainItem(context,gridItemModule.mainItem));
      items.add(_doubleItem(context,gridItemModule.Item1,gridItemModule.Item2));
      items.add(_doubleItem(context,gridItemModule.Item3,gridItemModule.Item4));
      List<Widget> expandItems=[];
      items.forEach((item) {
            expandItems.add(
              Expanded(child: item,flex: 1,),);
      });
    Color startColor=Color(int.parse("0xff"+gridItemModule.startColor));
    Color endColor=Color(int.parse("0xff"+gridItemModule.endColor));
    return Container(
      height: 100,
      margin: isFrist?null:const EdgeInsets.fromLTRB(0, 5, 0, 0),
      decoration: BoxDecoration(
        gradient:LinearGradient(colors: [startColor,endColor])
      ),
      child: Row(
        children:expandItems,
      ),
    );
  }
    _mainItem(BuildContext context,CommonModel commonModel){
        return _wrapGesture(
            context,
          Stack(
            alignment:AlignmentDirectional.topCenter,
            children: <Widget>[
              Image.network(
                commonModel.icon,
                fit: BoxFit.contain,
                height: 100,
                width: 120,
                alignment: AlignmentDirectional.bottomEnd,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  commonModel.title,
                  style: TextStyle(
                    fontSize: 15,color: Colors.deepOrange
                  ),
                ),
              )
            ],
          ),
        commonModel);
    }

 _doubleItem(BuildContext context,CommonModel topItemModel,bottonItemModel){
      return Column(
        children: <Widget>[
          Expanded(child: _item(context,topItemModel,true),),
          Expanded(child: _item(context,topItemModel,false),),
        ],
      );
 }

 _item(BuildContext context,CommonModel item,bool isFrist){
    BorderSide borderSide=BorderSide(width: 0.9,color:Colors.white);
    return FractionallySizedBox(
      //充满容器
      widthFactor: 1,
      child: Container(
          decoration:BoxDecoration(
            border: Border(
              left: borderSide,
              bottom: isFrist?borderSide:BorderSide.none,
            ),
          ) ,
        child: _wrapGesture(context,
            Center(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15
                ),
              ),
            ), item),
      ),

    );

 }

  _wrapGesture(BuildContext context,Widget widget,CommonModel commonModel){
        return GestureDetector(
          onTap:(){
              Navigator.push(context,
                  MaterialPageRoute(
                  builder:(context){
                    //todo webview
                    return WebView(
                      url: commonModel.url,
                      statusBarColor: commonModel.statusBarColor,
                      hideAppBar: commonModel.hideAppBar,
                      title: commonModel.title,
                    );
                  }
              ));
          },
          child: widget,
        );
  }
}