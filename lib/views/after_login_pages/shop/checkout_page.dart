import 'package:cached_network_image/cached_network_image.dart';
import 'package:eye_hospital/model/request/checkOut_req_model/create_order_req_model.dart';
import 'package:eye_hospital/model/response/cart_res/cart_res_model.dart';
import 'package:eye_hospital/model/response/product_res/product_res_model.dart';
import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/hive_service/address_service.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/view_model/after_login_controller/cart_controller/cart_controller.dart';
import 'package:eye_hospital/view_model/after_login_controller/shop_controller/checkout_controller.dart';
import 'package:eye_hospital/view_model/after_login_controller/shop_controller/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final CheckoutController controller = Get.put(CheckoutController());

  final PaymentController paymentCtr = Get.put(PaymentController());

  final CartController cartCtr = Get.find();

  final _formKey = GlobalKey<FormState>();

  final Map data = Get.arguments ?? {};

  bool get isDirect => data["isDirect"] == true;

  List<CartItem>? get cartItems => data["items"];

  Product get product => data["product"];

  int? get index => data["index"];

  CreateOrderReqModel buildOrderRequest() {
    /// ✅ Items
    List<Item> items = [];

    if (isDirect) {
      /// Direct product buy
      items.add(Item(productId: product.id, quantity: 1));
    } else if (cartItems != null && cartItems!.isNotEmpty) {
      /// From cart: all selected items
      for (var cartItem in cartItems!) {
        items.add(
          Item(
            productId: cartItem.product?.id,
            quantity: cartItem.quantity ?? 1,
          ),
        );
      }
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

    return CreateOrderReqModel(
      items: items,
      shippingInfo: shipping,
      paymentMethod: "",
      paymentInfo: PaymentInfo(json: {}),
      promoCode: controller.promoCode.text,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadDefaultAddress();
  }

  void loadDefaultAddress() {
    final data = AddressService.getDefaultAddress();

    if (data != null) {
      controller.fullName.text = data["fullName"] ?? "";
      controller.lastName.text = data["lastName"] ?? "";
      controller.address.text = data["address"] ?? "";
      controller.city.text = data["city"] ?? "";
      controller.state.text = data["state"] ?? "";
      controller.country.text = data["country"] ?? "";
      controller.zip.text = data["zip"] ?? "";
      controller.phone.text = data["phone"] ?? "";
    }
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
                selectedAddressCard(),
                const SizedBox(height: 10),
                shippingInfoCard(),
                const SizedBox(height: 16),

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
                if (!_formKey.currentState!.validate()) return;

                /// ✅ SAVE ADDRESS
                if (controller.saveInfo.value) {
                  final newAddress = {
                    "id": DateTime.now().toString(),
                    "fullName": controller.fullName.text,
                    "lastName": controller.lastName.text,
                    "address": controller.address.text,
                    "city": controller.city.text,
                    "state": controller.state.text,
                    "country": controller.country.text,
                    "zip": controller.zip.text,
                    "phone": controller.phone.text,
                    "isDefault": true,
                  };

                  await AddressService.addAddress(newAddress);
                }

                final req = buildOrderRequest();
                await paymentCtr.startPayment(req);
              },
      ),
    );
  }

  Widget selectedAddressCard() {
    if (controller.address.text.isEmpty) return SizedBox.shrink();

    return Container(
      // margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Address Details",
                style: text15(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "${controller.fullName.text} (${controller.phone.text})",
            style: text14(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            "${controller.address.text}, ${controller.city.text}, ${controller.state.text} - ${controller.zip.text}",
            style: text12(),
          ),
        ],
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Shipping Information",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () async {
                  final selected = await Get.to(() => SelectAddressPage());

                  if (selected != null) {
                    /// ✅ SET SELECTED ADDRESS
                    controller.fullName.text = selected["fullName"] ?? "";
                    controller.lastName.text = selected["lastName"] ?? "";
                    controller.address.text = selected["address"] ?? "";
                    controller.city.text = selected["city"] ?? "";
                    controller.state.text = selected["state"] ?? "";
                    controller.country.text = selected["country"] ?? "";
                    controller.zip.text = selected["zip"] ?? "";
                    controller.phone.text = selected["phone"] ?? "";

                    /// OPTIONAL: make it default
                    await AddressService.setDefault(selected["id"]);

                    setState(() {}); // refresh UI
                  }
                },
                child: const Text("Change"),
              ),
            ],
          ),
          const SizedBox(height: 12),
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
    if (cartItems == null || cartItems!.isEmpty) {
      return SizedBox.shrink();
    }

    return sectionCard(
      title: "Order Summary",
      child: Column(
        children: cartItems!.asMap().entries.map((entry) {
          final index = entry.key;
          final cartItem = entry.value;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                /// Product Image
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: cartItem.product!.images.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: cartItem.product!.images.first,
                          fit: BoxFit.contain,
                        )
                      : Image.asset(AppImages.frame, fit: BoxFit.contain),
                ),
                const SizedBox(width: 12),

                /// Name, category, price, quantity
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem.product?.name ?? '',
                        style: text14(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        cartItem.product?.category ?? '',
                        style: text12(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 6),
                      Obx(() {
                        final updatedItem =
                            cartCtr.cartData.value.data!.items[index];

                        final price =
                            updatedItem.product?.discountedPrice ??
                            updatedItem.product?.price ??
                            0;

                        final total = price * (updatedItem.quantity ?? 1);

                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text("₹$total/-"),
                        );
                      }),
                      const SizedBox(height: 6),

                      /// Quantity Row
                      Obx(() {
                        final updatedItem =
                            cartCtr.cartData.value.data!.items[index];

                        return Row(
                          children: [
                            quantityButton("-", () {
                              if ((updatedItem.quantity ?? 0) > 1) {
                                cartCtr.changeQuantityLocally(
                                  index: index,
                                  newQuantity: (updatedItem.quantity ?? 0) - 1,
                                );
                              }
                            }),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                (updatedItem.quantity ?? 0).toString(),
                                style: text15(fontWeight: FontWeight.w600),
                              ),
                            ),

                            quantityButton("+", () {
                              cartCtr.changeQuantityLocally(
                                index: index,
                                newQuantity: (updatedItem.quantity ?? 0) + 1,
                              );
                            }),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
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

class SelectAddressPage extends StatefulWidget {
  const SelectAddressPage({super.key});

  @override
  State<SelectAddressPage> createState() => _SelectAddressPageState();
}

class _SelectAddressPageState extends State<SelectAddressPage> {
  List<Map<String, dynamic>> addresses = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() {
    addresses = AddressService.getAddresses();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        shadowColor: AppColors.grey.shade100,
        title: Text("Select Address", style: text18(color: AppColors.black)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: addresses.isEmpty
          ? const Center(child: Text("No Address Found"))
          : ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final a = addresses[index];

                return GestureDetector(
                  onTap: () {
                    Get.back(result: a);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: a["isDefault"] == true
                            ? AppColors.success
                            : AppColors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      children: [
                        /// Address Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${a["fullName"]} (${a["phone"]})",
                                style: text15(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${a["address"]}, ${a["city"]}, ${a["state"]}, - ${a["zip"]}",
                                style: text13(),
                              ),
                              if (a["isDefault"] == true)
                                Text(
                                  "Default",
                                  style: text12(color: Colors.green),
                                ),
                            ],
                          ),
                        ),

                        /// ❌ DELETE BUTTON
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await AddressService.deleteAddress(a["id"]);
                            load(); // refresh list
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

      // /// ➕ Add New Address Button
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     // await Get.to(() => AddEditAddressPage());
      //     load();
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
