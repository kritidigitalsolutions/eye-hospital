import 'package:eye_hospital/model/response/product_res/product_res_model.dart';

class BookmarkResModel {
  bool? success;
  final List<BookmarkItem> bookmarks;

  BookmarkResModel({this.success, required this.bookmarks});

  factory BookmarkResModel.fromJson(Map<String, dynamic> json) {
    return BookmarkResModel(
      success: json["success"],
      bookmarks: json["bookmarks"] == null
          ? []
          : List<BookmarkItem>.from(
              json["bookmarks"].map((x) => BookmarkItem.fromJson(x)),
            ),
    );
  }
}

class BookmarkItem {
  final String? id;
  final Product? product;

  BookmarkItem({this.id, this.product});

  factory BookmarkItem.fromJson(Map<String, dynamic> json) {
    return BookmarkItem(
      id: json["_id"],
      product: json["product"] == null
          ? null
          : Product.fromJson(json["product"]),
    );
  }
}
