class OrderModel {
  final String id;
  final String orderId;
  final String status;
  final double total;
  final String createdAt;
  final List<OrderItem> items;

  OrderModel({
    required this.id,
    required this.orderId,
    required this.status,
    required this.total,
    required this.createdAt,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["_id"] ?? "",
      orderId: json["orderId"] ?? "",
      status: json["status"] ?? "",
      total: (json["total"] ?? 0).toDouble(),
      createdAt: json["createdAt"] ?? "",
      items: (json["items"] as List)
          .map((e) => OrderItem.fromJson(e))
          .toList(),
    );
  }
}

class OrderItem {
  final String name;
  final String image;
  final int quantity;
  final int price;
  final String color;

  OrderItem({
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    required this.color,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      name: json["name"] ?? "",
      image: json["image"] ?? "",
      quantity: json["quantity"] ?? 0,
      price: json["price"] ?? 0,
      color: json["selectedColor"] ?? "",
    );
  }
}
