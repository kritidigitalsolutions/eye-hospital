class CartResModel {
  bool? success;
  List<CartItem> items = [];
  int? total;

  CartResModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];

    if (json['items'] != null) {
      items = (json['items'] as List)
          .map((e) => CartItem.fromJson(e))
          .toList();
    }

    total = json['total'];
  }
}

class CartItem {
  CastProduct? product;
  int? quantity;
  String? selectedColor;

  CartItem.fromJson(Map<String, dynamic> json) {
    product = json['product'] != null
        ? CastProduct.fromJson(json['product'])
        : null;

    quantity = json['quantity'];
    selectedColor = json['selectedColor'];
  }
}

class CastProduct {
  String? id;
  String? name;
  String? category;
  int? price;
  int? discountedPrice;
  List<String>? images;

  CastProduct.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    category = json['category'];
    price = json['price'];
    discountedPrice = json['discountedPrice'];
    images = json['images'] != null
        ? List<String>.from(json['images'])
        : [];
  }
}
