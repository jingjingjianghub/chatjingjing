import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttershow/module/common_model.dart';
import 'package:fluttershow/weights/webview.dart';

class LocalNav extends StatelessWidget{
  final List<CommonModel> localNavList;
  LocalNav({Key key,@required this.localNavList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 65,
        decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                  Radius.circular(10),
              )
        ),
      child: Padding(padding: EdgeInsets.all(10),
                      child: _items(context),
      ),
    );
  }
_items(BuildContext context){
    if(localNavList==null){
        return null;
    }
    List<Widget> items=[];
    localNavList.forEach((model) {
        items.add(_item(context,model));
    });
      return Row(
        //排列方式
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      );
  }
  Widget _item(BuildContext context,CommonModel model){
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=>
                  WebView(
                    url: model.url,
                    statusBarColor: model.statusBarColor,
                    hideAppBar: model.hideAppBar,
                  )
            ));
          },
        child: Column(
          children: <Widget>[
            Image.network(
              model.icon,
              height: 25,
              width: 25,
            ),
            Text(
              model.title,
              style: TextStyle(
                fontSize: 15
              ),
            ),
          ],
        ),
        );
  }
}