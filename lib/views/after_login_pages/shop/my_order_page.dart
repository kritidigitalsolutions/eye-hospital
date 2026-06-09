import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/home_components.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/views/shimmer_widget/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../view_model/after_login_controller/shop_controller/checkout_controller.dart';

class MyOrderPage extends StatelessWidget {
  MyOrderPage({super.key});

  final CheckoutController controller = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.gif_box, size: 22),
                  SizedBox(width: 8),
                  Text("My Order", style: text18(fontWeight: FontWeight.bold)),
                ],
              ),

              const SizedBox(height: 6),

              Text(
                "Stay updated on your\neyewear delivery",
                textAlign: TextAlign.center,
                style: text14(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return buildShimmerList();
                  }

                  if (controller.orders.isEmpty) {
                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => controller.fetchOrders(),
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            EmptyStateWidget(
                              animation: AppImages.order,
                              title: "No Order found Yet",
                              subtitle:
                                  "Your orders will appear here.\nExplore products and place your first order.",
                              buttonText: "Start Shopping",
                              onTap: () => Get.toNamed(AppRoutes.productPage),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => controller.fetchOrders(),
                      child: ListView.builder(
                        itemCount: controller.orders.length,
                        itemBuilder: (context, index) {
                          final order = controller.orders[index];
                          final item = order.items.first;

                          return trackingCard(order, item);
                        },
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget trackingCard(order, item) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.orderDetails, arguments: order.orderId);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.yellow3],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 70,
              width: 70,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.network(item.image ?? "", fit: BoxFit.contain),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name ?? "",
                    style: text16(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Eyeglass Frame",
                    style: text12(fontWeight: FontWeight.w600),
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
                      "₹ ${item.price}/-",
                      style: text12(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            Text("View Details", style: text11(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
