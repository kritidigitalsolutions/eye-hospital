class MyOrderResModel {
  MyOrderResModel({
    required this.success,
    required this.total,
    required this.page,
    required this.totalPages,
    required this.orders,
  });

  final bool? success;
  final int? total;
  final int? page;
  final int? totalPages;
  final List<Order> orders;

  factory MyOrderResModel.fromJson(Map<String, dynamic> json) {
    return MyOrderResModel(
      success: json["success"],
      total: json["total"],
      page: json["page"],
      totalPages: json["totalPages"],
      orders: json["orders"] == null
          ? []
          : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
    );
  }
}

class Order {
  Order({
    required this.shippingInfo,
    required this.paymentInfo,
    required this.courierDetails,
    required this.id,
    required this.user,
    required this.items,
    required this.paymentMethod,
    required this.promoCode,
    required this.discount,
    required this.subtotal,
    required this.shippingCharge,
    required this.total,
    required this.status,
    required this.expectedDelivery,
    required this.cancelledBy,
    required this.cancelReason,
    required this.adminNote,
    required this.createdAt,
    required this.updatedAt,
    required this.orderId,
    required this.v,
  });

  final ShippingInfo? shippingInfo;
  final PaymentInfo? paymentInfo;
  final CourierDetails? courierDetails;
  final String? id;
  final String? user;
  final List<Item> items;
  final String? paymentMethod;
  final String? promoCode;
  final int? discount;
  final int? subtotal;
  final int? shippingCharge;
  final int? total;
  final String? status;
  final dynamic expectedDelivery;
  final dynamic cancelledBy;
  final String? cancelReason;
  final String? adminNote;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? orderId;
  final int? v;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      shippingInfo: json["shippingInfo"] == null
          ? null
          : ShippingInfo.fromJson(json["shippingInfo"]),
      paymentInfo: json["paymentInfo"] == null
          ? null
          : PaymentInfo.fromJson(json["paymentInfo"]),
      courierDetails: json["courierDetails"] == null
          ? null
          : CourierDetails.fromJson(json["courierDetails"]),
      id: json["_id"],
      user: json["user"],
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      paymentMethod: json["paymentMethod"],
      promoCode: json["promoCode"],
      discount: json["discount"],
      subtotal: json["subtotal"],
      shippingCharge: json["shippingCharge"],
      total: json["total"],
      status: json["status"],
      expectedDelivery: json["expectedDelivery"],
      cancelledBy: json["cancelledBy"],
      cancelReason: json["cancelReason"],
      adminNote: json["adminNote"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      orderId: json["orderId"],
      v: json["__v"],
    );
  }
}

class CourierDetails {
  CourierDetails({required this.partner, required this.trackingNumber});

  final String? partner;
  final String? trackingNumber;

  factory CourierDetails.fromJson(Map<String, dynamic> json) {
    return CourierDetails(
      partner: json["partner"],
      trackingNumber: json["trackingNumber"],
    );
  }
}

class Item {
  Item({
    required this.product,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.selectedColor,
    required this.category,
    required this.id,
  });

  final String? product;
  final String? name;
  final String? image;
  final int? price;
  final int? quantity;
  final String? selectedColor;
  final String? category;
  final String? id;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      product: json["product"],
      name: json["name"],
      image: json["image"],
      price: json["price"],
      quantity: json["quantity"],
      selectedColor: json["selectedColor"],
      category: json["category"],
      id: json["_id"],
    );
  }
}

class PaymentInfo {
  PaymentInfo({
    required this.paymentGateway,
    required this.gatewayOrderId,
    required this.paymentSessionId,
    required this.paymentStatus,
    required this.cardLastFour,
    required this.nameOnCard,
    required this.gatewayPaymentId,
  });

  final String? paymentGateway;
  final String? gatewayOrderId;
  final String? paymentSessionId;
  final String? paymentStatus;
  final String? cardLastFour;
  final String? nameOnCard;
  final String? gatewayPaymentId;

  factory PaymentInfo.fromJson(Map<String, dynamic> json) {
    return PaymentInfo(
      paymentGateway: json["paymentGateway"],
      gatewayOrderId: json["gatewayOrderId"],
      paymentSessionId: json["paymentSessionId"],
      paymentStatus: json["paymentStatus"],
      cardLastFour: json["cardLastFour"],
      nameOnCard: json["nameOnCard"],
      gatewayPaymentId: json["gatewayPaymentId"],
    );
  }
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

  factory ShippingInfo.fromJson(Map<String, dynamic> json) {
    return ShippingInfo(
      fullName: json["fullName"],
      lastName: json["lastName"],
      address: json["address"],
      city: json["city"],
      zipCode: json["zipCode"],
      state: json["state"],
      country: json["country"],
      phone: json["phone"],
      saveForNextTime: json["saveForNextTime"],
    );
  }
}
