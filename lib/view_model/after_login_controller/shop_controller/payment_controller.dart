// payment_controller.dart
import 'package:eye_hospital/data/api_response.dart';
import 'package:eye_hospital/model/request/checkOut_req_model/create_order_req_model.dart';
import 'package:eye_hospital/model/response/checkout_res/create_order_res_model.dart';
import 'package:eye_hospital/repo/payment_repo.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final isLoading = false.obs;
  final statusMessage = RxString('');

  final _repo = PaymentRepo();

  var createOrder = ApiResponse<CreateOrderResModel>.completed(null).obs;

  Future<void> startPayment(CreateOrderReqModel model) async {
    isLoading.value = true;
    statusMessage.value = '';

    final sessionData = await _repo.createOrderAndGetSession(model);

    createOrder.value = ApiResponse.completed(sessionData);

    final order = createOrder.value.data?.payment;

    if (order?.gatewayOrderId == null || order?.paymentSessionId == null) {
      isLoading.value = false;
      statusMessage.value = "Failed to create order. Please try again.";
      return;
    } else {
      await _repo.doPayment(
        context: Get.context!, // requires GetMaterialApp
        orderId: order?.gatewayOrderId ?? '',
        paymentSessionId: order?.paymentSessionId ?? '',
        onPaymentInitiated: () {
          statusMessage.value = "Opening payment page...";
        },
        onVerifySuccess: (orderId) {
          isLoading.value = false;
          statusMessage.value =
              "Payment processed (Order: $orderId)\nWe are confirming via server...";
          // TODO: Here you should call your backend to verify payment status
          // e.g. Get.snackbar("Success", "Payment initiated – awaiting confirmation");
        },
        onFailure: (error) {
          isLoading.value = false;
          statusMessage.value = "Payment failed: $error";
          // Get.snackbar("Error", error, backgroundColor: Colors.red);
        },
      );
    }
    isLoading.value = false;
  }

  @override
  void onClose() {
    // Optional: clean up if needed
    super.onClose();
  }
}
