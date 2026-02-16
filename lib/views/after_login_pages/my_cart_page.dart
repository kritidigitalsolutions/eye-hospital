import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_dimensions.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/view_model/after_login_controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCartPage extends StatelessWidget {
  MyCartPage({super.key});

  final MyCartController ctr = Get.put(MyCartController());

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
                  Icon(Icons.shopping_cart, color: AppColors.grey),
                  SizedBox(width: 8),
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

              /// List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  ctr.initCount(5);
                  return likedProductCard(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget likedProductCard(int index) {
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
                      child: Obx(
                        () => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  ctr.decrease(index);
                                },
                                child: Icon(Icons.remove, size: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(ctr.productCount[index].toString()),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  ctr.increase(index);
                                },
                                child: Icon(Icons.add, size: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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

                    Text("Remove", style: text11(color: AppColors.error)),
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
      margin: EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(color: AppColors.grey),
    );
  }
}
