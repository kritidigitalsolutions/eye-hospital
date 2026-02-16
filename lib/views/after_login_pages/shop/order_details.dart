import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// Order ID Box
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 18,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    richText("Order ID: ", "#ORD12345"),
                    SizedBox(height: 10),
                    richText("Order Date: ", "25 Jan 2025"),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// Product Card
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
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.grey),
                    color: AppColors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: AppColors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(AppImages.on3, fit: BoxFit.contain),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Classic Round Frame",
                              style: text15(fontWeight: FontWeight.bold),
                            ),
                            Text("Eyeglass Frame", style: text12()),
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
                                "₹250/-",
                                style: text14(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text("View Details", style: text11()),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// Order Status
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffE6EE4A),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(FontAwesomeIcons.boxOpen, size: 14),
                      SizedBox(width: 6),
                      Text("Order Status"),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),
              orderStatusTimeline(),
              const SizedBox(height: 12),

              /// Expected Delivery
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: richText("Expected Delivery:", " 30 Jan 2025"),
              ),

              const SizedBox(height: 16),

              // /// Map Image
              // Container(
              //   height: 180,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(12),
              //     color: Colors.grey.shade300,
              //   ),
              //   child: Image.asset("assets/map.png", fit: BoxFit.cover),
              // ),
              const SizedBox(height: 16),

              /// Courier Details
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.grey),
                  color: AppColors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Courier Details",
                      style: text15(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text("Courier Partner: BlueDart"),
                    Text("Tracking Number: BD123456789"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget statusRow(
    String title,
    String subtitle,
    Color color, {
    IconData icon = Icons.circle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget orderStatusTimeline() {
  return Column(
    children: [
      statusItem(
        title: "Order Confirmed",
        subtitle: "Your order has been placed successfully",
        color: AppColors.success,
        isLast: false,
      ),
      statusItem(
        title: "Shipped",
        subtitle: "Your order is on the way",
        color: AppColors.success,
        isLast: false,
      ),
      statusItem(
        title: "Out for Delivery",
        subtitle: "(Upcoming)",
        color: AppColors.yellowGr1,
        icon: Icons.local_shipping,
        isLast: false,
      ),
      statusItem(
        title: "Delivered",
        subtitle: "(Pending)",
        color: AppColors.error,
        isLast: true,
      ),
    ],
  );
}

Widget statusItem({
  required String title,
  required String subtitle,
  required Color color,
  IconData icon = Icons.circle,
  bool isLast = false,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      /// Left indicator
      Column(
        children: [
          Icon(icon, color: color, size: 12),

          if (!isLast) ...[
            containerLine(),
            containerLine(),
            containerLine(),
            containerLine(),
            containerLine(),
          ],

          // Container(
          //   height: 30,
          //   width: 1,
          //   margin: const EdgeInsets.symmetric(vertical: 4),
          //   decoration: BoxDecoration(
          //     border: Border(
          //       left: BorderSide(
          //         color: AppColors.grey,
          //         width: 1,
          //         style: BorderStyle.solid,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),

      const SizedBox(width: 10),

      /// Text
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: text14(fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(subtitle, style: text11(color: AppColors.textSecondary)),
            const SizedBox(height: 12),
          ],
        ),
      ),
    ],
  );
}

Widget richText(String title, String value) {
  return RichText(
    text: TextSpan(
      style: text13(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w600,
      ),
      children: [
        TextSpan(
          text: title,
          style: text15(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        TextSpan(text: value),
      ],
    ),
  );
}

Widget containerLine() {
  return Container(
    height: 5,
    width: 1,
    margin: const EdgeInsets.symmetric(vertical: 1),
    decoration: BoxDecoration(
      border: Border(
        left: BorderSide(
          color: AppColors.grey,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
    ),
  );
}
