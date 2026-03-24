import 'package:cached_network_image/cached_network_image.dart';
import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_dimensions.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/home_components.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/views/shimmer_widget/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/api_response.dart';
import '../../view_model/after_login_controller/cart_controller/cart_controller.dart';

class MyCartPage extends StatelessWidget {
  MyCartPage({super.key});

  final CartController cartCtr = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),

            /// Title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart, color: AppColors.grey),
                const SizedBox(width: 8),
                Text(
                  "My Cart",
                  style: text18(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "Review your selected items",
              style: text12(color: AppColors.textSecondary),
            ),

            /// Cart List From API
            Expanded(
              child: Obx(() {
                if (cartCtr.cartData.value.status == Status.loading) {
                  return buildShimmerList();
                }

                if (cartCtr.cartData.value.data == null ||
                    cartCtr.cartData.value.data!.items.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: () => cartCtr.getCart(),
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        EmptyStateWidget(
                          animation: AppImages.empty,
                          title: "Your Cart is Empty",
                          subtitle:
                              "Looks like you haven't added anything yet.",
                          buttonText: "Start Shopping",
                          onTap: () => Get.toNamed(AppRoutes.productPage),
                        ),
                      ],
                    ),
                  );
                }

                final items = cartCtr.cartData.value.data!.items;

                return RefreshIndicator(
                  onRefresh: () => cartCtr.getCart(),
                  child: ListView.builder(
                    padding: EdgeInsets.all(15),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: items.length + 1, // Add extra space for checkout
                    itemBuilder: (context, index) {
                      if (index == items.length) {
                        // Bottom Checkout Section
                        return checkoutSection();
                      }
                      return likedProductCard(index);
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Bottom Checkout Section
  Widget checkoutSection() {
    final totalAmount = cartCtr.cartData.value.data!.items.fold(0.0, (
      previousValue,
      item,
    ) {
      final price = item.product?.discountedPrice ?? item.product?.price ?? 0;
      return previousValue + (price * (item.quantity ?? 1));
    });

    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.yellow3],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Total Price
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total", style: text14(color: AppColors.textSecondary)),
              Text(
                "₹$totalAmount/-",
                style: text16(fontWeight: FontWeight.bold),
              ),
            ],
          ),

          /// Checkout Button
          elevatedButton(
            text: "Proceed to Checkout",
            background: AppColors.primary,
            textColor: AppColors.textPrimary,
            onPressed: () {
              final items = cartCtr.cartData.value.data!.items;
              if (items.isNotEmpty) {
                Get.toNamed(
                  AppRoutes.checkoutPage,
                  arguments: {"items": items}, // Pass all cart items
                );
              } else {
                Get.snackbar(
                  "Cart Empty",
                  "Please add some items to checkout",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  /// Product Card
  Widget likedProductCard(int index) {
    final item = cartCtr.cartData.value.data?.items[index];
    final product = item?.product;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.yellow3],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radius15),
      ),
      child: Row(
        children: [
          /// Image
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: product?.images != null && product!.images.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: product.images.first,
                      fit: BoxFit.contain,
                      placeholder: (context, url) {
                        return Center(
                          child: SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.buttonPrimary,
                            ),
                          ),
                        );
                      },
                    )
                  : Image.asset(AppImages.frame, fit: BoxFit.contain),
            ),
          ),

          const SizedBox(width: 12),

          /// Details
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Product Name
                Text(
                  product?.name ?? "",
                  style: text15(fontWeight: FontWeight.bold),
                ),

                /// Category (optional dynamic)
                Text(
                  product?.category ?? "",
                  style: text12(color: AppColors.textSecondary),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    Obx(() {
                      final updatedItem =
                          cartCtr.cartData.value.data!.items[index];

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

                    const SizedBox(width: 10),

                    /// Quantity (UI same, dynamic value)
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Obx(() {
                        final updatedItem =
                            cartCtr.cartData.value.data!.items[index];

                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // ➖ MINUS
                            GestureDetector(
                              onTap: () {
                                if ((updatedItem.quantity ?? 0) > 1) {
                                  cartCtr.changeQuantityLocally(
                                    index: index,
                                    newQuantity:
                                        (updatedItem.quantity ?? 0) - 1,
                                  );
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Icon(Icons.remove, size: 16),
                              ),
                            ),

                            // 🔢 QUANTITY TEXT
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                (updatedItem.quantity ?? 0).toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            // ➕ PLUS
                            GestureDetector(
                              onTap: () {
                                cartCtr.changeQuantityLocally(
                                  index: index,
                                  newQuantity: (updatedItem.quantity ?? 0) + 1,
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Icon(Icons.add, size: 16),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.productDetails,
                          arguments: product,
                        );
                      },
                      child: Text("View Details", style: text11()),
                    ),

                    containerLine(),

                    GestureDetector(
                      onTap: () {
                        final productId = item?.product?.id ?? '';

                        /// ✅ Step 1: instant UI remove
                        cartCtr.removeCartLocally(index: index);

                        /// ✅ Step 2: background API call
                        cartCtr.removeCart(productId: productId);
                      },
                      child: Text(
                        "Remove",
                        style: text11(color: AppColors.error),
                      ),
                    ),
                    // containerLine(),
                    // GestureDetector(
                    //   onTap: () {
                    //     final updatedItem =
                    //         cartCtr.cartData.value.data!.items[index];

                    //     Get.toNamed(
                    //       AppRoutes.checkoutPage,
                    //       arguments: {
                    //         "isDirect": false,
                    //         "item": updatedItem,
                    //         "index": index,
                    //       },
                    //     );
                    //   },
                    //   child: Text(
                    //     "Buy Now",
                    //     style: text11(color: AppColors.error),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget containerLine() {
    return Container(
      height: 10,
      width: 2,
      margin: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(color: AppColors.grey),
    );
  }
}
