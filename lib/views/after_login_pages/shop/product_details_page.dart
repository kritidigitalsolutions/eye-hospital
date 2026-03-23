import 'package:cached_network_image/cached_network_image.dart';
import 'package:eye_hospital/model/response/product_res/product_res_model.dart';
import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../view_model/after_login_controller/bookmark_controller/bookmark_controller.dart';
import '../../../view_model/after_login_controller/cart_controller/cart_controller.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({super.key});

  final Product product = Get.arguments as Product;
  final CartController cartCtr = Get.find();
  final BookmarkController bookmarkCtr = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          "Product Details",
          style: text16(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        shadowColor: AppColors.grey.shade100,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.myCart);
            },
            icon: Icon(Icons.shopping_cart_checkout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: product.images.isNotEmpty
                        ? product.images.first
                        : "",
                    height: 150,

                    errorWidget: (_, __, ___) =>
                        const Icon(Icons.image_not_supported, size: 100),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    product.name ?? "",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  /// Icons row
                  Obx(() {
                    // final isCart = cartCtr.isProductInCart(product.id ?? '');
                    final isBookmark = bookmarkCtr.isProductBookmark(
                      product.id ?? '',
                    );
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // IconButton(
                        //   icon: Icon(
                        //     isCart
                        //         ? Icons.shopping_cart
                        //         : Icons.shopping_cart_outlined,
                        //     color: isCart ? AppColors.error : AppColors.black,
                        //   ),
                        //   onPressed: () {
                        //     if (isCart) {
                        //       cartCtr.removeCart(productId: product.id ?? '');
                        //     } else {
                        //       cartCtr.addToCart(
                        //         productId: product.id ?? "",
                        //         quantity: 1,
                        //         selectedColor: "",
                        //       );
                        //     }
                        //   },
                        // ),
                        IconButton(
                          icon: Icon(
                            color: isBookmark
                                ? AppColors.error
                                : AppColors.black,
                            isBookmark ? Icons.favorite : Icons.favorite_border,
                            size: 23,
                          ),
                          onPressed: () {
                            if (isBookmark) {
                              bookmarkCtr.removeBookmark(product.id ?? '');
                            } else {
                              bookmarkCtr.addBookmark(product.id ?? "");
                            }
                          },
                        ),
                        Icon(Icons.share, size: 23),
                      ],
                    );
                  }),

                  const SizedBox(height: 15),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "₹ ${product.discountedPrice ?? product.price ?? 0}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// Available Colors
            sectionTitle("Available Colors"),
            const SizedBox(height: 8),
            Wrap(
              children: product.availableColors
                  .map((color) => ColorChip(text: color))
                  .toList(),
            ),

            const SizedBox(height: 16),

            /// Product Highlights
            sectionTitle("Product Highlights"),
            const SizedBox(height: 8),
            ...product.highlights.map((e) => highlightText(e)),

            const SizedBox(height: 16),

            /// Frame Details
            sectionTitle("Frame Details"),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: frameRow(
                    "Frame Type",
                    product.frameDetails?.frameType ?? "-",
                  ),
                ),
                Expanded(
                  child: frameRow(
                    "Frame Size",
                    product.frameDetails?.frameSize ?? "-",
                  ),
                ),
                Expanded(
                  child: frameRow(
                    "Frame Shape",
                    product.frameDetails?.frameShape ?? "-",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: frameRow(
                    "Gender",
                    product.frameDetails?.gender ?? "-",
                  ),
                ),
                Expanded(
                  child: frameRow(
                    "Material",
                    product.frameDetails?.frameMaterial ?? "-",
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),

            const SizedBox(height: 20),

            /// Buy Now Button
            Obx(() {
              final isCart = cartCtr.isProductInCart(product.id ?? '');
              if (!isCart) {
                return CustomButton(
                  isLoading: cartCtr.isLoading.value,
                  title: "Add To Cart",
                  onPressed: () async {
                    /// ✅ Step 1: Add to cart
                    await cartCtr.addToCart(
                      productId: product.id ?? "",
                      quantity: 1,
                      selectedColor: "",
                    );

                    /// ✅ Step 2: Refresh cart (IMPORTANT)
                    await cartCtr.getCart();

                    /// ✅ Step 3: Find added item index
                    final items = cartCtr.cartData.value.data?.items ?? [];

                    final index = items.indexWhere(
                      (e) => e.product?.id == product.id,
                    );

                    if (index == -1) {
                      Get.snackbar("Error", "Item not found in cart");
                      return;
                    }

                    final updatedItem = items[index];

                    /// ✅ Step 4: Navigate like Cart Page
                    Get.toNamed(
                      AppRoutes.checkoutPage,
                      arguments: {
                        "isDirect": false,
                        "item": updatedItem,
                        "index": index,
                      },
                    );
                  },
                );
              }

              return SizedBox.shrink();
            }),
            const SizedBox(height: 10),
            CustomButton(
              title: "Buy Now",
              onPressed: () {
                Get.toNamed(
                  AppRoutes.checkoutPage,
                  arguments: {
                    "isDirect": true,
                    "product": product, // 👈 pass product here
                  },
                );
              },
            ),

            const SizedBox(height: 16),

            /// Care Instructions
            sectionTitle("Care Instructions"),
            ...product.careInstructions.map((e) => highlightText(e)),

            const SizedBox(height: 16),

            /// review section
            sectionTitle("Reviews"),
            const SizedBox(height: 8),
            elevatedButton(
              text: "Write a Review",
              background: AppColors.primary,
              textColor: AppColors.textPrimary,
              onPressed: () {
                Get.toNamed(AppRoutes.productReview, arguments: product);
              },
            ),

            /// Customer Reviews (static UI for now)
            sectionTitle("Customer Reviews"),
            const SizedBox(height: 8),
            Column(children: List.generate(3, (index) => reviewCard())),
          ],
        ),
      ),
    );
  }

  /// Widgets
  static Widget sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    );
  }

  static Widget highlightText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          const Icon(Icons.check, size: 15, color: AppColors.success),
          const SizedBox(width: 6),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  static Widget frameRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  static Widget reviewCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primary.withAlpha(100),
            radius: 30,
            child: const Text("R"),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Radhika", style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Text(
                  "Very comfortable and stylish frame. Value for money.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Color chip widget
class ColorChip extends StatelessWidget {
  final String text;

  const ColorChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
