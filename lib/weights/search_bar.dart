import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum SearchBarType {
    home,normal,homeLight
}
class SearchBar extends  StatefulWidget{
  //是否禁止搜索
  final bool enabled;
  final bool hideLeft;
  final SearchBarType searchBarType;
  final String hint;
  final String defaultText;
  final void Function() leftButtonClick;
  final void Function() rightButtonClick;
  final void Function() speakClick;
  final void Function() inputBoxClick;
  final ValueChanged<String> onChange;

  SearchBar({
    this.enabled=true,
    this.hideLeft,
    this.searchBarType=SearchBarType.normal,
    this.hint,
    this.defaultText,
    this.leftButtonClick,
    this.rightButtonClick,
    this.speakClick,
    this.inputBoxClick,
    this.onChange
});
  @override
  State<StatefulWidget> createState() {
      return _SearchBarState();
  }
}
class _SearchBarState extends State<SearchBar>{
  bool  showClear=false;
  final TextEditingController  _controller=TextEditingController();
  @override
  void initState() {
    if(widget.defaultText!=null){
          setState(() {
              _controller.text=widget.defaultText;
          });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType==SearchBarType.normal?_getNormalSearch():_getHomeSearch();

  }
  _getNormalSearch(){
    return Container(
      padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
      child: Row(
        children: <Widget>[
          _wrapTap(
            Container(
              child: widget.hideLeft??false?null:Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
                size: 26,
              ),
            ),
          widget.leftButtonClick
          ),
          Expanded(
            child: _inputBox(),
            flex: 1,
          ),
          _wrapTap(
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                "搜索",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
            ),
            widget.leftButtonClick
          )
        ],
      ),
    );
  }
  _getHomeSearch(){
    return Container(
      padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
      child: Row(
        children: <Widget>[
          _wrapTap(
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    "天津",
                    style: TextStyle(
                      fontSize: 15,
                      color: _homeFontColor(),
                    ),
                  ),
                  Icon(
                    Icons.expand_more,
                    color: _homeFontColor(),
                    size: 20,
                  ),

                ],
              ),
            ),
          widget.leftButtonClick
          ),
          Expanded(
            child: _inputBox(),
            flex: 1,
          ),
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Icon(
                  Icons.comment,
                  color:_homeFontColor(),
                  size: 30,
                ),
              ),
            widget.leftButtonClick
          ),

        ],
      ),

    );
  }

  _wrapTap(Widget child,void Function() callBack){
        return GestureDetector(
          onTap: (){
            if(callBack!=null)callBack();
          },
          child: child,
        );
    }
    _inputBox(){
        Color inputBoxColor;
        if(widget.searchBarType ==SearchBarType.home){
            inputBoxColor=Colors.white;
        }else{
          inputBoxColor =Color(int.parse("0xffededed"));
        }
        return Container(
          height: 30,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
            color: inputBoxColor,
            borderRadius: BorderRadius.circular(
                widget.searchBarType==SearchBarType.normal?5:15),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.search,
                color: widget.searchBarType==SearchBarType.normal?Color(0xffA9A9):Colors.blue,
              ),
              Expanded(
                flex: 1,
                child: widget.searchBarType==SearchBarType.normal?TextField(
                  controller: _controller,
                  onChanged: _onChange,
                  autofocus: true,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    border: InputBorder.none,
                    hintText: widget.hint??"",
                    hintStyle: TextStyle(
                      fontSize: 15
                    ),
                  ),
                ):_wrapTap(
                    Container(
                      child: Text(
                        widget.defaultText,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey
                        ),
                      ),
                    ),
                    widget.inputBoxClick
                 ),
              ),
              !showClear?
                  _wrapTap(Icon(
                    Icons.mic,
                    size: 20,
                    color: widget.searchBarType ==SearchBarType.normal?
                    Colors.blue:Colors.grey,),
                     widget.speakClick
                         ):GestureDetector(
                onTap: (){
                  print("清空了");
                  setState(() {
                    _controller.clear();
                  });
                  _onChange("");
                },
                child: Icon(
                  Icons.clear,
                  size: 20,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        );
    }
_onChange(String text){
    if(text.length>0){
      setState(() {
        showClear=true;
      });
    }else{
      setState(() {
        showClear=false;
      });
    }
    if(widget.onChange!=null){
      widget.onChange(text);
    }
}
  _homeFontColor(){
    return widget.searchBarType==SearchBarType.home
        ?Colors.white
        :Colors.black45;
  }
}