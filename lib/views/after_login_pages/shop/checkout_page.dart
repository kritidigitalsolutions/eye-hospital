import 'package:cached_network_image/cached_network_image.dart';
import 'package:eye_hospital/model/request/checkOut_req_model/create_order_req_model.dart';
import 'package:eye_hospital/model/response/cart_res/cart_res_model.dart';
import 'package:eye_hospital/model/response/product_res/product_res_model.dart';
import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/view_model/after_login_controller/cart_controller/cart_controller.dart';
import 'package:eye_hospital/view_model/after_login_controller/shop_controller/checkout_controller.dart';
import 'package:eye_hospital/view_model/after_login_controller/shop_controller/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({super.key});

  final CheckoutController controller = Get.put(CheckoutController());
  final PaymentController paymentCtr = Get.put(PaymentController());
  final CartController cartCtr = Get.find();
  final _formKey = GlobalKey<FormState>();

  final Map data = Get.arguments ?? {};

  bool get isDirect => data["isDirect"] == true;

  CartItem? get item => data["item"];
  Product get product => data["product"];
  int? get index => data["index"];

  CreateOrderReqModel buildOrderRequest() {
    /// ✅ Items
    List<Item> items = [];

    if (isDirect) {
      /// 👉 Direct product buy
      items.add(Item(productId: product.id, quantity: 1));
    } else {
      /// 👉 From cart
      final cartItem = item!;
      items.add(
        Item(productId: cartItem.product?.id, quantity: cartItem.quantity ?? 1),
      );
    }

    /// ✅ Shipping Info
    final shipping = ShippingInfo(
      fullName: controller.fullName.text,
      lastName: controller.lastName.text,
      address: controller.address.text,
      city: controller.city.text,
      zipCode: controller.zip.text,
      state: controller.state.text,
      country: controller.country.text,
      phone: controller.phone.text,
      saveForNextTime: controller.saveInfo.value,
    );

    /// ✅ Payment Method
    String paymentMethod;
    switch (controller.selectedPayment.value) {
      case 0:
        paymentMethod = "card";
        break;
      case 1:
        paymentMethod = "paypal";
        break;
      case 2:
        paymentMethod = "apple_pay";
        break;
      case 3:
        paymentMethod = "cod";
        break;
      default:
        paymentMethod = "card";
    }

    return CreateOrderReqModel(
      items: items,
      shippingInfo: shipping,
      paymentMethod: paymentMethod,
      paymentInfo: PaymentInfo(json: {}),
      promoCode: controller.promoCode.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      body: SafeArea(
        child: Form(
          // ✅ ADD THIS
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (!isDirect) orderSummaryCard(),
                if (isDirect) directOrderSummaryCard(),
                const SizedBox(height: 16),

                shippingInfoCard(),
                const SizedBox(height: 16),
                // paymentMethodCard(),
                // const SizedBox(height: 16),
                promoCodeCard(),

                const SizedBox(height: 20),
                paymentButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ------------------------button------------------------

  Widget paymentButton() {
    return Obx(
      () => CustomButton(
        title: paymentCtr.isLoading.value ? "Processing..." : "Payment Now",
        onPressed: paymentCtr.isLoading.value
            ? () {}
            : () async {
                /// ✅ FORM VALIDATION
                if (!_formKey.currentState!.validate()) {
                  return;
                }

                final req = buildOrderRequest();

                await paymentCtr.startPayment(req);
              },
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
          field(
            controller.address,
            "Address",
            validator: (v) => v == null || v.isEmpty ? "Enter address" : null,
          ),
          rowFields(controller.city, "City", controller.zip, "Zip Code"),
          rowFields(controller.state, "State", controller.country, "Country"),
          field(
            controller.phone,
            "Phone Number",
            validator: (v) {
              if (v == null || v.isEmpty) return "Enter phone number";
              if (!RegExp(r'^[0-9]{10}$').hasMatch(v)) {
                return "Invalid phone";
              }
              return null;
            },
          ),
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
            child: item!.product!.images.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: item?.product?.images.first ?? '',
                    fit: BoxFit.contain,
                  )
                : Image.asset(AppImages.frame, fit: BoxFit.contain),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item?.product?.name ?? '',
                  style: text14(fontWeight: FontWeight.bold),
                ),
                Text(
                  item?.product?.category ?? "",
                  style: text12(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 6),
                Obx(() {
                  final updatedItem =
                      cartCtr.cartData.value.data!.items[data['index']];

                  final price =
                      item?.product?.discountedPrice ??
                      item?.product?.price ??
                      0;

                  final quantity = updatedItem.quantity ?? 1;

                  final total = price * quantity;

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "₹$total/-",
                      style: text12(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          Obx(() {
            final updatedItem =
                cartCtr.cartData.value.data!.items[data['index']];

            return Row(
              children: [
                quantityButton("-", () {
                  if ((updatedItem.quantity ?? 0) > 1) {
                    cartCtr.changeQuantityLocally(
                      index: data['index'],
                      newQuantity: (updatedItem.quantity ?? 0) - 1,
                    );
                  }
                }),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    (updatedItem.quantity ?? 0).toString(),
                    style: text15(fontWeight: FontWeight.w600),
                  ),
                ),

                quantityButton("+", () {
                  cartCtr.changeQuantityLocally(
                    index: data['index'],
                    newQuantity: (updatedItem.quantity ?? 0) + 1,
                  );
                }),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget directOrderSummaryCard() {
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
            child: product.images.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: product.images.first,
                    fit: BoxFit.contain,
                  )
                : Image.asset(AppImages.frame, fit: BoxFit.contain),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name ?? '',
                  style: text14(fontWeight: FontWeight.bold),
                ),
                Text(
                  product.category ?? "",
                  style: text12(color: AppColors.textSecondary),
                ),
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
                  child: Text(
                    "₹${product.discountedPrice ?? product.price ?? 0}/-",
                  ),
                ),
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

  Widget field(
    TextEditingController c,
    String hint, {
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: c,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: validator,
      ),
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
        Expanded(
          child: field(
            c1,
            h1,
            validator: (v) => v == null || v.isEmpty ? "Required" : null,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: field(
            c2,
            h2,
            validator: (v) => v == null || v.isEmpty ? "Required" : null,
          ),
        ),
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
