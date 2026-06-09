import 'package:cached_network_image/cached_network_image.dart';
import 'package:eye_hospital/data/api_response.dart';
import 'package:eye_hospital/model/response/product_res/product_res_model.dart';
import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/home_components.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/view_model/after_login_controller/bookmark_controller/bookmark_controller.dart';
import 'package:eye_hospital/view_model/after_login_controller/shop_controller/product_controller.dart';
import 'package:eye_hospital/views/shimmer_widget/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view_model/after_login_controller/cart_controller/cart_controller.dart';
import '../../../view_model/after_login_controller/profile_controller/profile_controller.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ctr = Get.put(ProductController());
  final profileCtr = Get.put(EditProfileController());
  final CartController cartCtr = Get.find();
  final BookmarkController bookmarkCtr = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage(AppImages.femaleDoctor),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello",
                        style: text14(
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Obx(
                        () => Text(
                          profileCtr.name.value,
                          // "Ashish",
                          style: text16(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),

              const Text(
                "Find the perfect frames and lenses\nfor your vision and style",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              /// Category Chips
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(ctr.categories.length, (index) {
                    final isSelected = ctr.selectedCategory.value == index;
                    return GestureDetector(
                      onTap: () {
                        ctr.selectedCategory.value = index;
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.grey),
                        ),
                        child: Text(ctr.categories[index]),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 16),

              /// Grid Products
              Expanded(
                child: Obx(() {
                  final status = ctr.productList.value.status;

                  switch (status) {
                    case Status.loading:
                      return GridView.builder(
                        itemCount: 6,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.90,
                            ),
                        itemBuilder: (context, index) {
                          return shimmerProductCard();
                        },
                      );

                    case Status.error:
                      return Center(
                        child: Text(
                          ctr.productList.value.message ??
                              "Something went wrong",
                        ),
                      );

                    case Status.completed:
                      final products = ctr.filteredProducts;

                      if (products.isEmpty) {
                        return buildError("No product found", () {
                          ctr.fetchProduct();
                        });
                      }

                      return RefreshIndicator(
                        onRefresh: ctr.fetchProduct,
                        child: GridView.builder(
                          itemCount: products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 0.90,
                              ),
                          itemBuilder: (context, index) {
                            return productCard(products[index]);
                          },
                        ),
                      );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productCard(Product item) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.productDetails, arguments: item);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image from API
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: CachedNetworkImage(
                      imageUrl: item.images.isNotEmpty ? item.images.first : "",
                      fit: BoxFit.cover,

                      errorWidget: (_, _, _) => AspectRatio(
                        aspectRatio: 1.5,
                        child: Container(
                          color: AppColors.grey.shade300,
                          child: Center(
                            child: const Icon(Icons.image_not_supported),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Obx(() {
                  // final isCart = cartCtr.isProductInCart(item.id ?? '');
                  final isBookmark = bookmarkCtr.isProductBookmark(
                    item.id ?? '',
                  );

                  return Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          /// Cart Icon
                          // IconButton(
                          //   icon: Icon(
                          //     isCart
                          //         ? Icons.shopping_cart
                          //         : Icons.shopping_cart_outlined,
                          //     color: isCart ? AppColors.error : AppColors.black,
                          //   ),
                          //   onPressed: () {
                          //     if (isCart) {
                          //       cartCtr.removeCart(productId: item.id ?? '');
                          //     } else {
                          //       cartCtr.addToCart(
                          //         productId: item.id ?? "",
                          //         quantity: 1,
                          //         selectedColor: "Black",
                          //       );
                          //     }
                          //   },
                          // ),

                          /// Bookmark Icon
                          IconButton(
                            icon: Icon(
                              isBookmark
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isBookmark
                                  ? AppColors.error
                                  : AppColors.black,
                              size: 23,
                            ),
                            onPressed: () {
                              if (isBookmark) {
                                bookmarkCtr.removeBookmark(item.id ?? "");
                              } else {
                                bookmarkCtr.addBookmark(item.id ?? "");
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),

            SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                item.name ?? "",
                style: text14(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 6),

            Container(
              margin: EdgeInsets.only(left: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "₹ ${item.discountedPrice ?? item.price ?? 0}",
                style: text14(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
