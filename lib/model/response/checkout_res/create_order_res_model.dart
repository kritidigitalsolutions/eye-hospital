class CreateOrderResModel {
  CreateOrderResModel({
    required this.success,
    required this.message,
    //  required this.order,
    required this.payment,
  });

  final bool? success;
  final String? message;
  //   final Order? order;
  final Payment? payment;

  factory CreateOrderResModel.fromJson(Map<String, dynamic> json) {
    return CreateOrderResModel(
      success: json["success"],
      message: json["message"],
      //   order: json["order"] == null ? null : Order.fromJson(json["order"]),
      payment: json["payment"] == null
          ? null
          : Payment.fromJson(json["payment"]),
    );
  }
}

class Order {
  Order({
    required this.user,
    required this.items,
    required this.shippingInfo,

    // required this.paymentMethod,
    // required this.paymentInfo,
    // required this.promoCode,
    // required this.discount,
    // required this.subtotal,
    // required this.shippingCharge,
    // required this.total,
    // required this.status,
    // required this.statusTimeline,
    // required this.courierDetails,
    // required this.expectedDelivery,
    // required this.cancelledBy,
    // required this.cancelReason,
    // required this.adminNote,
    // required this.id,
  });

  final String? user;
  final List<Item> items;
  final ShippingInfo? shippingInfo;
  // final String? paymentMethod;
  // final PaymentInfo? paymentInfo;
  // final String? promoCode;
  // final int? discount;
  // final int? subtotal;
  // final int? shippingCharge;
  // final int? total;
  // final String? status;
  // final List<StatusTimeline> statusTimeline;
  // final CourierDetails? courierDetails;
  // final dynamic expectedDelivery;
  // final dynamic cancelledBy;
  // final String? cancelReason;
  // final String? adminNote;
  // final String? id;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      user: json["user"],
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      shippingInfo: json["shippingInfo"] == null
          ? null
          : ShippingInfo.fromJson(json["shippingInfo"]),

      // paymentMethod: json["paymentMethod"],
      // paymentInfo: json["paymentInfo"] == null ? null : PaymentInfo.fromJson(json["paymentInfo"]),
      // promoCode: json["promoCode"],
      // discount: json["discount"],
      // subtotal: json["subtotal"],
      // shippingCharge: json["shippingCharge"],
      // total: json["total"],
      // status: json["status"],
      // statusTimeline: json["statusTimeline"] == null ? [] : List<StatusTimeline>.from(json["statusTimeline"]!.map((x) => StatusTimeline.fromJson(x))),
      // courierDetails: json["courierDetails"] == null ? null : CourierDetails.fromJson(json["courierDetails"]),
      // expectedDelivery: json["expectedDelivery"],
      // cancelledBy: json["cancelledBy"],
      // cancelReason: json["cancelReason"],
      // adminNote: json["adminNote"],
      // id: json["_id"],
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

  Map<String, dynamic> toJson() => {
    "partner": partner,
    "trackingNumber": trackingNumber,
  };
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

class StatusTimeline {
  StatusTimeline({
    required this.status,
    required this.description,
    required this.timestamp,
    required this.id,
  });

  final String? status;
  final String? description;
  final DateTime? timestamp;
  final String? id;

  factory StatusTimeline.fromJson(Map<String, dynamic> json) {
    return StatusTimeline(
      status: json["status"],
      description: json["description"],
      timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
      id: json["_id"],
    );
  }
}

class Payment {
  Payment({
    required this.provider,
    required this.paymentSessionId,
    required this.gatewayOrderId,
  });

  final String? provider;
  final String? paymentSessionId;
  final String? gatewayOrderId;

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      provider: json["provider"],
      paymentSessionId: json["payment_session_id"],
      gatewayOrderId: json["gateway_order_id"],
    );
  }
}
