
import 'common_model.dart';

class GridNavModel{
  final GridItemModel hotel;
  final GridItemModel flight;
  final GridItemModel  travel;

  //todo 一旦你的字段是必选的那么不能用{}
  GridNavModel(
  {this.hotel,this.flight,this.travel}
  );
 factory  GridNavModel.fromJson(Map<String,dynamic>json){
    return json!=null ?
        GridNavModel(
          hotel: GridItemModel.fromJson(json["hotel"]),
          flight: GridItemModel.fromJson(json["flight"]),
          travel: GridItemModel.fromJson(json["travel"]),
        ):null;

 }
}
class GridItemModel{
    final String startColor;
    final String endColor;
    final CommonModel mainItem;
    final CommonModel Item1;
    final CommonModel Item2;
    final CommonModel Item3;
    final CommonModel Item4;
    GridItemModel(
    {
    this.startColor,
    this.endColor,
      this.Item1,
      this.Item2,
      this.Item3,
      this.Item4,
      this.mainItem
    }
        );
   factory GridItemModel.fromJson(Map<String,dynamic>json){
      return GridItemModel(
          startColor: json["startColor"],
          endColor: json["endColor"],
          mainItem: CommonModel.fromJson(json["mainItem"]),
        Item1: CommonModel.fromJson(json["Item1"]),
        Item2: CommonModel.fromJson(json["Item2"]),
        Item3: CommonModel.fromJson(json["Item3"]),
        Item4: CommonModel.fromJson(json["Item4"]),
      );
   }
}