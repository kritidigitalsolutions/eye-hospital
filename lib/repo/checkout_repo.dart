import 'package:eye_hospital/res/app_urls.dart';

import '../data/network/network_api_service.dart';
import '../model/request/checkOut_req_model/checkout_req_model.dart';
import '../model/response/checkout_res/checkout_res_model.dart';
import '../utils/hive_service/hive_service.dart';

class CheckoutRepo {
  final _api = NetworkApiService();

  Future<CheckoutResponseModel> submitOrder({
    required String firstName,
    required String lastName,
    required String address,
    required String city,
    required String zip,
    required String state,
    required String country,
    required String phone,
    required int paymentMethod,
    required String cardNumber,
    required String expiry,
    required String cvc,
    required String cardName,
    required String promoCode,
    required int quantity,
  }) async {

    try {

      final token = HiveService.getToken();
      _api.setToken(token ?? '');

      /// Payment method mapping
      String method = "cash_on_delivery";

      if (paymentMethod == 0) {
        method = "card";
      } else if (paymentMethod == 1) {
        method = "paypal";
      } else if (paymentMethod == 2) {
        method = "apple_pay";
      } else {
        method = "cash_on_delivery";
      }
      final body = {
        "fromCart": false,
        "items": [
          {
            "productId": "69a17a076c7e9ab6d37721f5",
            "quantity": quantity,
            "selectedColor": "Black"
          }
        ],
        "shippingInfo": {
          "fullName": firstName,
          "lastName": lastName,
          "address": address,
          "city": city,
          "zipCode": zip,
          "state": state,
          "country": country,
          "phone": phone,
          "saveForNextTime": true
        },
        "paymentMethod": method,

        "paymentInfo": paymentMethod == 0
            ? {
          "cardNumber": cardNumber,
          "expiry": expiry,
          "cvc": cvc,
          "cardName": cardName
        }
            : {},
        "promoCode": promoCode
      };
      final res = await _api.postApi(
        AppUrls.checkout,
        body,
      );
      return CheckoutResponseModel.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  // -------------------------------
  // ✅ Get cart
  // -------------------------------

  Future<List<OrderModel>> getMyOrders() async {
    try {

      final token = HiveService.getToken();
      _api.setToken(token ?? '');

      final res = await _api.getApi(AppUrls.getcheckout);

      print("FULL API RESPONSE: $res");

      List orders = res["orders"];

      return orders
          .map((order) => OrderModel.fromJson(order))
          .toList();

    } catch (e) {
      rethrow;
    }
  }
}
