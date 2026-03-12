import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_dimensions.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/views/shimmer_widget/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../data/api_response.dart';
import '../../view_model/after_login_controller/cart_controller/cart_controller.dart';

class MyCartPage extends StatelessWidget {
  MyCartPage({super.key});

  final CartController cartCtr = Get.put(CartController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
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

            const SizedBox(height: 16),

            /// Cart List From API
            Obx(() {
              if (cartCtr.cartData.value.status == Status.loading) {
                return buildShimmerList();
              }

              if (cartCtr.cartData.value.data == null ||
                  cartCtr.cartData.value.data!.items.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () => cartCtr.getCart(),
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [emptyCart()],
                  ),
                );
              }

              final items = cartCtr.cartData.value.data!.items;

              return Expanded(
                child: RefreshIndicator(
                  onRefresh: () => cartCtr.getCart(),
                  child: ListView.builder(
                    padding: EdgeInsets.all(15),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return likedProductCard(index);
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget emptyCart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),

        /// Lottie Animation
        Lottie.asset(AppImages.empty, height: 300),

        const SizedBox(height: 20),

        /// Title
        Text(
          "Your Cart is Empty",
          style: text16(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 6),

        /// Subtitle
        Text(
          "Looks like you haven't added\nany products yet.",
          textAlign: TextAlign.center,
          style: text12(color: AppColors.textSecondary),
        ),

        const SizedBox(height: 20),

        /// Optional Button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonPrimary,
          ),
          onPressed: () {
            Get.toNamed(AppRoutes.productPage);
          },
          child: Text("Start Shopping", style: text14()),
        ),
      ],
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
                  ? Image.network(product.images.first, fit: BoxFit.contain)
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
                    /// Price pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffE6EE4A),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "₹${product?.discountedPrice ?? product?.price ?? 0}/-",
                        style: text12(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

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
                        cartCtr.removeCart(productId: item?.product?.id ?? '');
                      },
                      child: Text(
                        "Remove",
                        style: text11(color: AppColors.error),
                      ),
                    ),
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
