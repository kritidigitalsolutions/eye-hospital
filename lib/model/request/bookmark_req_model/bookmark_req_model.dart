class BookmarkReqModel {

  String? productId;

  BookmarkReqModel({this.productId});

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
    };
  }
}
