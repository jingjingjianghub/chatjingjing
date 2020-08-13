import 'dart:convert';

import 'package:fluttershow/module/search_model.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
const KSearchUrl="https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contenType=json&keyword=";
class SearchDateManager{
  static Future<SearchModel>fetch(String url,String text)async{
    final http.Response response=await http.get(url);
    if(response.statusCode==200){
      //中文乱码修复
      Utf8Decoder utf8decoder=Utf8Decoder();
      //得到result
      var result=json.decode(utf8decoder.convert(response.bodyBytes));
      //防止搜索过快
      SearchModel searchModel=SearchModel.fromJson(result);
    }else{
      throw Exception("搜索接口调试失败");
    }

  }
}