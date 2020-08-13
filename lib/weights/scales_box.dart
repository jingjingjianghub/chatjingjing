import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttershow/module/common_model.dart';
import 'package:fluttershow/module/sales_box_model.dart';
import 'package:fluttershow/weights/webview.dart';

class SalesBox extends StatelessWidget{
  final SalesBoxModel salesBoxModel;
  SalesBox({Key key,@required this.salesBoxModel}):super(key:key);

  @override
  Widget build(BuildContext context) {
      return Container(
        child:_items(context),
        decoration: BoxDecoration(
          color: Colors.white,

        ),
      );
  }

  _items(BuildContext context){
      if(salesBoxModel==null){
            return null;
      }
      List<Widget> items=[];
      //todo 添加item
        items.add(_doubleItem(context, salesBoxModel.bigCard1, salesBoxModel.bigCard2, true, false));
        items.add(_doubleItem(context, salesBoxModel.smallCard1, salesBoxModel.smallCard2, false, false));
        items.add(_doubleItem(context, salesBoxModel.smallCard3, salesBoxModel.smallCard4, false, true));

      return Column(
        children: <Widget>[
            Container(
             height: 45,
             margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
             decoration: BoxDecoration(
               border:Border(
                 bottom: BorderSide(
                   color: Color(0xfff2f2f2),width: 1
                 )
               )
             ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 Image.network(
                  salesBoxModel.icon,
                  height: 15,
                  fit: BoxFit.fill,
                 ),
                 Container(
                   padding: EdgeInsets.fromLTRB(10, 1, 6, 1),
                   margin: EdgeInsets.fromLTRB(0, 0, 6, 0),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(15),
                     gradient: LinearGradient(
                       colors: [Color(0xffff2e33),Color(0xffff2cc3)],
                       begin:Alignment.centerLeft,
                       end: Alignment.centerRight,
                     )
                   ),
                   child: GestureDetector(
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(
                         builder: (context){
                          return WebView(
                              url: salesBoxModel.moreUrl,
                              title: "更多",
                          ) ;
                         }
                       ));
                     },
                     child: Text(
                       "更多福利",
                       style: TextStyle(
                         fontSize: 15,
                         color: Colors.white
                       ),
                     ),
                   ),
                 )
               ],
             ),
            ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:items.sublist(0,1),
        ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:items.sublist(1,2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:items.sublist(2,3),
          )
        ],
      );
  }

  Widget _doubleItem(BuildContext context,
       CommonModel leftCard,
       CommonModel rightCard,
       bool isBig,
       bool isLast){
    Row (
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _item(context,leftCard,true,isLast,isBig),
        _item(context,rightCard,false,isLast,isBig),
      ],
    );
  }
  Widget _item(BuildContext context,CommonModel model,bool isLeft,bool isLast,bool isBig){
        BorderSide borderSide=BorderSide(
          width: 1,
          color: Color(0xff22f2f6),

        );
        return GestureDetector(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(
                builder: (context)=>WebView(
                  url: model.url,
                  statusBarColor: model.statusBarColor,
                  hideAppBar: model.hideAppBar,
                )
            ));
          },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
             right: isLeft ?borderSide :BorderSide.none,
             bottom: isLast ?borderSide:BorderSide.none,
            )
          ),
          child: Image.network(
            model.url,
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width/2-10,
            height: isBig?130:80,
          ),
        ),
        );
  }

}