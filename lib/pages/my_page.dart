import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttershow/redux/app_starte.dart';
import 'package:fluttershow/weights/webview.dart';

class Mypage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyPageState();
  }

}
class _MyPageState extends State<Mypage>{
  @override
  Widget build(BuildContext context) {
      return StoreBuilder<AppState>(
        builder: (context,store){
          return Scaffold(
          body:  WebView(
            url: "https://m.ctrip.com/webapp/myctrip",
            hideAppBar: true,
            backForbid: false,
            statusBarColor:"5c5bbc",
          ),
          );
        },
      );
  }

}