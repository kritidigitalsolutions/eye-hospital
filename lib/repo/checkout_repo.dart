import 'package:eye_hospital/res/app_urls.dart';

import '../data/network/network_api_service.dart';
import '../model/request/checkOut_req_model/checkout_req_model.dart';
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

      final body = {
        "first_name": firstName,
        "last_name": lastName,
        "address": address,
        "city": city,
        "zip": zip,
        "state": state,
        "country": country,
        "phone": phone,
        "payment_method": paymentMethod,
        "card_number": cardNumber,
        "expiry_date": expiry,
        "cvc": cvc,
        "card_name": cardName,
        "promo_code": promoCode,
        "quantity": quantity,
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
}
