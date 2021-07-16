

class QueryModel {
  late String queryHead;
  late String queryDes;
  late String queryImg;
  late String queryUrl;
  QueryModel(
      {this.queryHead = "HEADLINE",
      this.queryDes = "SOME",
      this.queryImg = " URL",
      this.queryUrl = " URL"});

  factory QueryModel.fromMap(Map query) {
    try {
      return QueryModel(
          queryHead: query["title"],
          queryDes: query["description"],
          queryImg: query["urlToImage"],
          queryUrl: query["url"]);
    } catch (e) {
      var container;
      return container;
    }
  }
}
