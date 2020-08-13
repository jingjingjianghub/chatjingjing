import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttershow/redux/app_starte.dart';

class  SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      return _SearchPageState();
  }

}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
      return StoreBuilder<AppState>(
        builder: (context,store){
          return Scaffold(
            body: Text("搜索页面"),
          );
        },
      );
  }
}