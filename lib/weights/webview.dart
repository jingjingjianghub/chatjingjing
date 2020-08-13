

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

List<String> CATCH_URL=["https://m.ctrip.com/",
  "https://m.ctrip.com/html5/","https://m.ctrip.com/html5"];
class WebView extends StatefulWidget{
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebView({
    this.url,this.statusBarColor,this.title,this.hideAppBar,this.backForbid
});

  @override
  State<StatefulWidget> createState() {

    return _WebViewState();
  }
}
class _WebViewState extends State<WebView>{
  final FlutterWebviewPlugin webviewPlugin=FlutterWebviewPlugin();

  //todo 状态的变化
  StreamSubscription<String> _onUrlChange;
  StreamSubscription<WebViewStateChanged> _onStateChange;
  StreamSubscription<WebViewHttpError> _onHttpError;

  bool exiting=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webviewPlugin.close();
    _onUrlChange=webviewPlugin.onUrlChanged.listen((String url){

    });
    _onStateChange=webviewPlugin.onStateChanged.listen((WebViewStateChanged state){
        switch(state.type){
          case WebViewState.startLoad:
            print("WebView 加载的url是${state.url}");
            if(_isToMain(state.url)&&!exiting){
              if(widget.backForbid){
                  webviewPlugin.launch(widget.url);
              }else{
                Navigator.pop(context);
                exiting=true;
              }
        }
            break;
            default:
              break;
      }
    });
    _onHttpError=webviewPlugin.onHttpError.listen((WebViewHttpError error) {
          print("webView发生异常$error");
    });
  }

  _isToMain(String url){
    bool contain=false;
    if(CATCH_URL.contains(url)){
        contain=true;
    }
    return contain;
  }
  @override
  Widget build(BuildContext context) {

    String statusBarColor=widget.statusBarColor  ?? "ffffff";
    Color backButtonColor;
    if(statusBarColor=="ffffff"){
        backButtonColor=Colors.black;
    }else{
      backButtonColor=Colors.white;
    }
    return Scaffold(
      body:Container(
        height: 1000,
        width: 1000,
        child:  Column(
          children: <Widget>[
            _appBar(Color(int.parse("0xff"+statusBarColor)),backButtonColor),
            Expanded(
              child: WebviewScaffold(
                url: widget.url,
                withZoom: true,
                withLocalStorage: true,
                hidden: true,
                initialChild: Container(
                  color:  Colors.white,
                  child: Center(
                    child: Text("加载中。。。"),
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _appBar(Color backgroundColor,Color backBottonColor){
        if(widget.hideAppBar??false){
          return Container(
            color: backgroundColor,
            height: 50,
          );
        }
        return Container(
          color:backgroundColor,
          padding: EdgeInsets.fromLTRB(0, 50, 0, 100),
          child: FractionallySizedBox(
            widthFactor: 1,
            child: Stack(
              children: <Widget>[
                GestureDetector(
                 child: Container(
                   margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                   child: Icon(
                     Icons.close,
                     color: backBottonColor,
                     size: 30,
                   ),
                 ),
                  onTap: (){
                   Navigator.pop(context);
                  },
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      widget.title??"",
                      style: TextStyle(
                        color: backBottonColor,
                        fontSize: 20
                      ),
                    ),
                  ),

                ),
              ],

            ),
          ),

        );
}

  @override
  void dispose() {
    _onHttpError.cancel();
    _onUrlChange.cancel();
    _onStateChange.cancel();
    webviewPlugin.dispose();
    super.dispose();
  }
}