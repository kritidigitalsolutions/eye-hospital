import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CheckoutController extends GetxController {
  // Shipping controllers
  final fullName = TextEditingController();
  final lastName = TextEditingController();
  final address = TextEditingController();
  final city = TextEditingController();
  final zip = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  final phone = TextEditingController();

  // Payment controllers
  final cardNumber = TextEditingController();
  final expiry = TextEditingController();
  final cvc = TextEditingController();
  final cardName = TextEditingController();
  final promoCode = TextEditingController();

  // UI state
  RxBool saveInfo = true.obs;
  RxInt selectedPayment = 0.obs; // 0-card,1-paypal,2-apple,3-cod
  RxInt quantity = 1.obs;

  void increaseQty() => quantity.value++;
  void decreaseQty() {
    if (quantity.value > 1) quantity.value--;
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
