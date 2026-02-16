import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/custom_textfields.dart';
import 'package:eye_hospital/view_model/after_login_controller/shop_controller/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({super.key});

  final CheckoutController controller = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              shippingInfoCard(),
              const SizedBox(height: 16),
              paymentMethodCard(),
              const SizedBox(height: 16),
              promoCodeCard(),
              const SizedBox(height: 16),
              orderSummaryCard(),
              const SizedBox(height: 20),
              CustomButton(
                title: 'Confirm Order',
                onPressed: () {
                  Get.toNamed(AppRoutes.orderDetails);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= SHIPPING INFO =================
  Widget shippingInfoCard() {
    return sectionCard(
      title: "Shipping Information",
      child: Column(
        children: [
          rowFields(
            controller.fullName,
            "Full Name",
            controller.lastName,
            "Last Name",
          ),
          field(controller.address, "Address"),
          rowFields(controller.city, "City", controller.zip, "Zip Code"),
          rowFields(controller.state, "State", controller.country, "Country"),
          field(controller.phone, "Phone Number"),
          Obx(
            () => Row(
              children: [
                Checkbox(
                  value: controller.saveInfo.value,
                  onChanged: (v) => controller.saveInfo.value = v!,
                ),
                const Text("Save this information for next time"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= PAYMENT =================
  Widget paymentMethodCard() {
    return sectionCard(
      title: "Payment Method",
      child: Column(
        children: [
          paymentOption("Credit/Debit Card", 0),
          paymentOption("PayPal", 1),
          paymentOption("Apple Pay", 2),
          field(controller.cardNumber, "Card Number"),
          rowFields(controller.expiry, "Expiry Date", controller.cvc, "CVC"),
          field(controller.cardName, "Name on Card"),
          paymentOption("Cash on Delivery", 3),
        ],
      ),
    );
  }

  // ================= PROMO =================
  Widget promoCodeCard() {
    return sectionCard(
      title: "Promo Code",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: field(controller.promoCode, "Enter Code")),
          const SizedBox(width: 8),
          elevatedButton(
            text: "Apply",
            background: AppColors.buttonPrimary,
            textColor: AppColors.textSecondary,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // ================= ORDER SUMMARY =================
  Widget orderSummaryCard() {
    return sectionCard(
      title: "Order Summary",
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(AppImages.frame),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Classic Round Frame",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text("Eyeglass frame"),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text("₹250/-"),
                ),
              ],
            ),
          ),
          Obx(
            () => Row(
              children: [
                quantityButton("-", controller.decreaseQty),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(controller.quantity.value.toString()),
                ),
                quantityButton("+", controller.increaseQty),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= COMMON =================
  Widget sectionCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget field(TextEditingController c, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CustomTextFieldWithBorder(controller: c, hintText: hint),
    );
  }

  Widget rowFields(
    TextEditingController c1,
    String h1,
    TextEditingController c2,
    String h2,
  ) {
    return Row(
      children: [
        Expanded(child: field(c1, h1)),
        const SizedBox(width: 8),
        Expanded(child: field(c2, h2)),
      ],
    );
  }

  Widget paymentOption(String text, int index) {
    return Obx(
      () => Row(
        children: [
          Radio<int>(
            value: index,
            groupValue: controller.selectedPayment.value,
            onChanged: (v) => controller.selectedPayment.value = v!,
          ),
          Text(text),
        ],
      ),
    );
  }

  Widget quantityButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(child: Text(text)),
      ),
    );
  }
}
