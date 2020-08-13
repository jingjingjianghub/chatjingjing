import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttershow/module/common_model.dart';
import 'package:fluttershow/weights/webview.dart';

class SubNav extends StatelessWidget{
  final List<CommonModel> subNavList;
  SubNav({Key key,@required this.subNavList}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
      ),
        child: Padding(padding: EdgeInsets.all(8),
          child: _items(context),
        ),
    );
  }
    _items(BuildContext context){
    if(subNavList==null){
        return null;
    }
    List<Widget>items=[];
    subNavList.forEach((model) {
          items.add(_item(context,model));
    });
    int separate=(subNavList.length/2+0.5).toInt();
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.sublist(0,separate),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:items.sublist(separate,items.length),
          ),
        )
      ],
    );
  }
Widget _item(BuildContext context,CommonModel model){
      return Expanded(
        flex: 1,
        child: GestureDetector(
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
                height: 20,
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(
                  model.title,
                  style: TextStyle(
                    fontSize: 15
                  ),
                ),
              )
            ],
          ),
        ),
      ) ;
  }
}