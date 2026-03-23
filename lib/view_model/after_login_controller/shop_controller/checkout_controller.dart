import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../model/response/checkout_res/checkout_res_model.dart';
import '../../../repo/checkout_repo.dart';

class CheckoutController extends GetxController {
  final CheckoutRepo _repo = CheckoutRepo();

  // ================= Orders =================
  var orders = <OrderModel>[].obs;
  RxBool isLoading = false.obs;

  // ================= Shipping controllers =================
  final fullName = TextEditingController();
  final lastName = TextEditingController();
  final address = TextEditingController();
  final city = TextEditingController();
  final zip = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  final phone = TextEditingController();

  // ================= Payment controllers =================
  final cardNumber = TextEditingController();
  final expiry = TextEditingController();
  final cvc = TextEditingController();
  final cardName = TextEditingController();
  final promoCode = TextEditingController();

  // ================= UI State =================
  RxBool saveInfo = true.obs;
  RxInt selectedPayment = 0.obs;
  RxInt quantity = 1.obs;

  // ================= Submit Order =================
  Future<void> submitOrder() async {
    try {
      isLoading.value = true;

      await _repo.submitOrder(
        firstName: fullName.text,
        lastName: lastName.text,
        address: address.text,
        city: city.text,
        zip: zip.text,
        state: state.text,
        country: country.text,
        phone: phone.text,
        paymentMethod: selectedPayment.value,
        cardNumber: cardNumber.text,
        expiry: expiry.text,
        cvc: cvc.text,
        cardName: cardName.text,
        promoCode: promoCode.text,
        quantity: quantity.value,
      );

      Get.snackbar("Success", "Order Placed Successfully");

      // 🔥 Refresh Orders After Order Placed
      fetchOrders();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ================= Fetch Orders =================
  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;

      final data = await _repo.getMyOrders();

      orders.value = data;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ================= Lifecycle =================
  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  @override
  void onClose() {
    fullName.dispose();
    lastName.dispose();
    address.dispose();
    city.dispose();
    zip.dispose();
    state.dispose();
    country.dispose();
    phone.dispose();
    cardNumber.dispose();
    expiry.dispose();
    cvc.dispose();
    cardName.dispose();
    promoCode.dispose();

    super.onClose();
  }
}
