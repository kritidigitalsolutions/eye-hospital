// payment_repo.dart  (formerly CashfreeService / PaymentRepo)
import 'package:eye_hospital/model/request/checkOut_req_model/create_order_req_model.dart';
import 'package:eye_hospital/model/response/checkout_res/create_order_res_model.dart';
import 'package:eye_hospital/utils/hive_service/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:eye_hospital/data/network/network_api_service.dart';
import 'package:eye_hospital/res/app_urls.dart';

class PaymentRepo {
  static const String _environment =
      "PRODUCTION"; // Change to "PRODUCTION" later

  final _api = NetworkApiService();

  /// Creates order on backend and returns session data
  Future<CreateOrderResModel> createOrderAndGetSession(
    CreateOrderReqModel model,
  ) async {
    try {
      final token = HiveService.getToken();
      _api.setToken(token ?? '');
      final response = await _api.postApi(
        AppUrls.createOrder, // ← CHANGE THIS!
        model.toJson(),
      );
      return CreateOrderResModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Launches Cashfree Drop Checkout
  Future<void> doPayment({
    required BuildContext context,
    required String orderId,
    required String paymentSessionId,
    required VoidCallback onPaymentInitiated,
    required Function(String orderId) onVerifySuccess,
    required Function(String errorMsg) onFailure,
  }) async {
    try {
      final session = CFSessionBuilder()
          .setEnvironment(
            _environment == "PRODUCTION"
                ? CFEnvironment.PRODUCTION
                : CFEnvironment.SANDBOX,
          )
          .setOrderId(orderId)
          .setPaymentSessionId(paymentSessionId)
          .build();

      // Optional customization (uncomment if needed)
      // final paymentComponent = CFPaymentComponentBuilder()
      //     .setComponents([CFPaymentModes.UPI, CFPaymentModes.CARD])
      //     .build();
      // final theme = CFThemeBuilder()
      //     .setNavigationBarBackgroundColor("#your_brand_color")
      //     .build();

      final dropPayment = CFDropCheckoutPaymentBuilder()
          .setSession(session)
          // .setPaymentComponent(paymentComponent)
          // .setTheme(theme)
          .build();

      final cfService = CFPaymentGatewayService();

      cfService.setCallback(
        (String orderId) {
          onVerifySuccess(orderId);
        },
        (CFErrorResponse error, String? orderId) {
          final msg = error.getMessage() ?? "Payment failed";
          onFailure("$msg (Code: ${error.getCode()})");
        },
      );

      onPaymentInitiated();
      cfService.doPayment(dropPayment);
    } catch (e) {
      onFailure("Exception during payment setup: $e");
    }
  }
}
