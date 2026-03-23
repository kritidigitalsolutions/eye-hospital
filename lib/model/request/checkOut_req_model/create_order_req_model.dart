class CreateOrderReqModel {
  CreateOrderReqModel({
    required this.items,
    required this.shippingInfo,
    required this.paymentMethod,
    required this.paymentInfo,
    required this.promoCode,
  });

  final List<Item> items;
  final ShippingInfo? shippingInfo;
  final String? paymentMethod;
  final PaymentInfo? paymentInfo;
  final String? promoCode;

  Map<String, dynamic> toJson() => {
    "items": items.map((x) => x.toJson()).toList(),
    "shippingInfo": shippingInfo?.toJson(),
    "paymentMethod": paymentMethod,
    "paymentInfo": paymentInfo?.toJson(),
    "promoCode": promoCode,
  };
}

class Item {
  Item({required this.productId, required this.quantity});

  final String? productId;
  final int? quantity;

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "quantity": quantity,
  };
}

class PaymentInfo {
  PaymentInfo({required this.json});
  final Map<String, dynamic> json;

  Map<String, dynamic> toJson() => json;
}

class ShippingInfo {
  ShippingInfo({
    required this.fullName,
    required this.lastName,
    required this.address,
    required this.city,
    required this.zipCode,
    required this.state,
    required this.country,
    required this.phone,
    required this.saveForNextTime,
  });

  final String? fullName;
  final String? lastName;
  final String? address;
  final String? city;
  final String? zipCode;
  final String? state;
  final String? country;
  final String? phone;
  final bool? saveForNextTime;

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "lastName": lastName,
    "address": address,
    "city": city,
    "zipCode": zipCode,
    "state": state,
    "country": country,
    "phone": phone,
    "saveForNextTime": saveForNextTime,
  };
}
