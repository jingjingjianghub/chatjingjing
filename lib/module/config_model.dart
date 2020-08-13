
class ConfigModel{
  final String srearchUrl;
  ConfigModel(
  {this.srearchUrl}
      );
 factory  ConfigModel.fromJson(Map<String,dynamic>json){
      return ConfigModel(srearchUrl: json["searchUrl"]);
 }
 Map<String,dynamic>toJson(){
   return{srearchUrl:srearchUrl};
 }
}