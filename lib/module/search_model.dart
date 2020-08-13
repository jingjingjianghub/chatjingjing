class SearchModel{
    final String word;
    final String type;
    final String price;
    final String zonename;
    final String districtname;
    final String url;

    SearchModel({
      this.word,
      this.type,
      this.price,
      this.zonename,
      this.districtname,
      this.url
});
    factory SearchModel.fromJson(Map<String,dynamic>json){
      return SearchModel(
        word: json["word"],
        type: json["type"],
        price: json["price"],
        zonename: json["zonename"],
        districtname: json["districtname"],
        url: json["url"],
      );
    }
}