class AddCartRequest {
  final String productId;
  final int quantity;
  final String selectedColor;

  AddCartRequest({
    required this.productId,
    required this.quantity,
    required this.selectedColor,
  });

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "quantity": quantity,
      "selectedColor": selectedColor,
    };
  }
}
