
import 'dart:async';
import 'package:fluttershow/module/home_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
const kHomeUrl="https://www.devio.org/io/flutter_app/json/home_page.json?tdsourcetag=s_pcqq_aiomsg";
class HomeDataManager{
  static Future<HomeModel> fetch()async{
    final http.Response response=await http.get(kHomeUrl);
    //todo 接口调试失败 具体原因
    if(response.statusCode==200){
      //todo 转换
      Utf8Decoder utf8decoder=Utf8Decoder();
        var result=json.decode(utf8decoder.convert(response.bodyBytes));
            return HomeModel.fromJson(result);
    }else{
      throw Exception("接口调试失败");
    }
  }

}