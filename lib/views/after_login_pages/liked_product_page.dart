import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/view_model/after_login_controller/cart_controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view_model/after_login_controller/bookmark_controller/bookmark_controller.dart';

class LikedProductPage extends StatelessWidget {
  LikedProductPage({super.key});

  final BookmarkController controller = Get.find();
  final CartController cartCtr = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Obx(
          () => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite, color: AppColors.error),
                    SizedBox(width: 8),
                    Text(
                      "Liked Products",
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

                /// Loading
                if (controller.isLoading.value)
                  const Center(child: CircularProgressIndicator())
                /// Empty
                else if (controller.bookmarks.isEmpty)
                  const Center(child: Text("No liked products"))
                /// List
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.bookmarks.length,
                    itemBuilder: (context, index) {
                      final item = controller.bookmarks[index];
                      return likedProductCard(item);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget likedProductCard(item) {
    final product = item.product;

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.yellow3],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.grey),
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
                  child: Image.network(
                    product.images.isNotEmpty ? product.images.first : "",
                    errorBuilder: (_, __, ___) => const Icon(Icons.image),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              /// Details
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: text15(fontWeight: FontWeight.bold),
                    ),

                    Text(
                      product.category,
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
                            "₹${product.discountedPrice ?? product.price}/-",
                            style: text12(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        /// Quantity UI
                        // Container(
                        //   decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.black54),
                        //     borderRadius: BorderRadius.circular(20),
                        //   ),
                        //   child: Row(
                        //     children: const [
                        //       Padding(
                        //         padding: EdgeInsets.symmetric(horizontal: 8),
                        //         child: Text("-"),
                        //       ),
                        //       Padding(
                        //         padding: EdgeInsets.symmetric(horizontal: 8),
                        //         child: Text("1"),
                        //       ),
                        //       Padding(
                        //         padding: EdgeInsets.symmetric(horizontal: 8),
                        //         child: Text("+"),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            //  cartCtr.addToCart(productId: productId, quantity: quantity, selectedColor: selectedColor)
                            Get.toNamed(AppRoutes.myCart);
                          },
                          child: Text("Add to Cart", style: text11()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        /// Favorite Icon
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              controller.removeBookmark(product.id);
            },
            child: CircleAvatar(
              radius: 13,
              backgroundColor: AppColors.error,
              child: Icon(Icons.favorite, color: AppColors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget containerLine() {
    return Container(
      height: 10,
      width: 2,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(color: AppColors.grey),
    );
  }
}
