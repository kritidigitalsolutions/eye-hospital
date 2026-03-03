class CheckoutResponseModel {
  final bool? success;
  final String? message;

  CheckoutResponseModel({
    this.success,
    this.message,
  });

  factory CheckoutResponseModel.fromJson(Map<String, dynamic> json) {
    return CheckoutResponseModel(
      success: json['success'],
      message: json['message'],
    );
  }
}
