import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LikedProductPage extends StatelessWidget {
  const LikedProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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

              /// List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return likedProductCard();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget likedProductCard() {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.grey),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(AppImages.frame, fit: BoxFit.contain),
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
                      "Classic Round Frame",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: text15(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Eyeglass Frame",
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
                            "₹250/-",
                            style: text12(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        /// Quantity stepper
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text("-"),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text("1"),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text("+"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.productDetails,
                              arguments: {
                                "title": "Classic Spectacles",
                                "price": "Rs. 250",
                                "image": AppImages.on3,
                              },
                            );
                          },
                          child: Text("View Details", style: text11()),
                        ),
                        containerLine(),
                        GestureDetector(
                          onTap: () {
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
        Positioned(
          top: 10,
          right: 10,
          child: CircleAvatar(
            radius: 13,
            backgroundColor: AppColors.error,
            child: Icon(Icons.favorite, color: AppColors.white, size: 16),
          ),
        ),
      ],
    );
  }

  Widget containerLine() {
    return Container(
      height: 10,
      width: 2,
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(color: AppColors.grey),
    );
  }
}
