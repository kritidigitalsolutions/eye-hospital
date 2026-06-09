class TrackOrderModel {
  bool? success;
  Tracking? tracking;

  TrackOrderModel({this.success, this.tracking});

  TrackOrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    tracking =
    json['tracking'] != null ? Tracking.fromJson(json['tracking']) : null;
  }
}

class Tracking {
  String? orderId;
  String? orderDate;
  String? currentStatus;
  String? expectedDelivery;
  bool? isCancelled;
  String? cancelReason;
  String? paymentStatus;

  List<TrackingStep>? trackingSteps;
  List<TrackOrderItem>? items;
  CourierDetails? courierDetails;

  Tracking.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderDate = json['orderDate'];
    currentStatus = json['currentStatus'];
    expectedDelivery = json['expectedDelivery'];
    isCancelled = json['isCancelled'];
    cancelReason = json['cancelReason'];
    paymentStatus = json['paymentStatus'];

    if (json['trackingSteps'] != null) {
      trackingSteps = [];
      json['trackingSteps'].forEach((v) {
        trackingSteps!.add(TrackingStep.fromJson(v));
      });
    }

    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(TrackOrderItem.fromJson(v));
      });
    }

    courierDetails = json['courierDetails'] != null
        ? CourierDetails.fromJson(json['courierDetails'])
        : null;
  }
}

class TrackingStep {
  String? status;
  String? label;
  String? description;
  bool? completed;
  bool? isCurrent;

  TrackingStep.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    label = json['label'];
    description = json['description'];
    completed = json['completed'];
    isCurrent = json['isCurrent'];
  }
}

class TrackOrderItem {
  String? name;
  String? image;
  int? price;
  int? quantity;
  String? selectedColor;

  TrackOrderItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    price = json['price'];
    quantity = json['quantity'];
    selectedColor = json['selectedColor'];
  }
}

class CourierDetails {
  String? partner;
  String? trackingNumber;

  CourierDetails.fromJson(Map<String, dynamic> json) {
    partner = json['partner'];
    trackingNumber = json['trackingNumber'];
  }
}
