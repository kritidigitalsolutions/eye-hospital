import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../repo/checkout_repo.dart';

class CheckoutController extends GetxController {

  final CheckoutRepo _repo = CheckoutRepo();

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

  // ================= UI state =================
  RxBool saveInfo = true.obs;
  RxInt selectedPayment = 0.obs;
  RxInt quantity = 1.obs;

  // 🔥 ADD THIS (for loading state)
  RxBool isLoading = false.obs;

  void increaseQty() => quantity.value++;

  void decreaseQty() {
    if (quantity.value > 1) quantity.value--;
  }

  // 🔥 ADD THIS METHOD (API Call)
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

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
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
