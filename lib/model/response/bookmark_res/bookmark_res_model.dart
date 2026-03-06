class BookmarkResModel {

  bool? success;
  String? message;

  BookmarkResModel({
    this.success,
    this.message,
  });

  factory BookmarkResModel.fromJson(Map<String, dynamic> json) {
    return BookmarkResModel(
      success: json["success"],
      message: json["message"],
    );
  }
}


class BookmarkModel {
  final String id;
  final bookmarkProduct product;

  BookmarkModel({
    required this.id,
    required this.product,
  });

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      id: json["_id"],
      product: bookmarkProduct.fromJson(json["product"]),
    );
  }
}

class bookmarkProduct {
  final String id;
  final String name;
  final String category;
  final int price;
  final int discountedPrice;
  final List<String> images;

  bookmarkProduct({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.discountedPrice,
    required this.images,
  });

  factory bookmarkProduct.fromJson(Map<String, dynamic> json) {
    return bookmarkProduct(
      id: json["_id"],
      name: json["name"],
      category: json["category"],
      price: json["price"],
      discountedPrice: json["discountedPrice"] ?? json["price"] ?? 0,
      images: List<String>.from(json["images"]),
    );
  }
}
