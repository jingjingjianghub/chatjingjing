import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttershow/redux/app_starte.dart';

class TravelPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
        return _TravelPageState();
  }

}

class _TravelPageState extends State<TravelPage>{
  @override
  Widget build(BuildContext context) {
        return StoreBuilder<AppState>(
          builder: (context,store){
            return Scaffold(
                body: Text("旅行"),
            );
          },
        );
  }
}