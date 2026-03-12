import 'package:eye_hospital/model/response/product_res/product_res_model.dart';

class CartResModel {
  final bool? success;
  final List<CartItem> items;
  final int? total;

  CartResModel({this.success, required this.items, this.total});

  factory CartResModel.fromJson(Map<String, dynamic> json) {
    return CartResModel(
      success: json['success'],
      total: json['total'],
      items: json["items"] == null
          ? []
          : List<CartItem>.from(json["items"].map((x) => CartItem.fromJson(x))),
    );
  }
}

class CartItem {
  final Product? product;
  final int? quantity;
  final String? selectedColor;
  final String? id;

  CartItem({this.product, this.quantity, this.selectedColor, this.id});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: json["product"] == null
          ? null
          : Product.fromJson(json["product"]),
      quantity: json["quantity"],
      selectedColor: json["selectedColor"],
      id: json["_id"],
    );
  }
}
