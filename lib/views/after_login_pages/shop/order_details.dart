import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../res/app_colors.dart';
import '../../../utils/textstyle.dart';
import '../../../view_model/after_login_controller/shop_controller/track_order_controllar.dart';

class OrderDetailsPage extends StatelessWidget {
  OrderDetailsPage({super.key});

  final OrderController controller = Get.put(OrderController());
  final orderId = Get.arguments ?? "";

  @override
  Widget build(BuildContext context) {
    if (orderId != null) {
      controller.getTrackOrder(orderId);
    }
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text("Order Details"),
        elevation: 1,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        shadowColor: AppColors.grey.shade100,
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.orderData.value?.tracking;

        if (data == null) {
          return const Center(child: Text("No Data"));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// ORDER ID
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    richText("Order ID: ", data.orderId ?? ""),
                    const SizedBox(height: 8),
                    richText("Order Date: ", data.orderDate ?? ""),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// PRODUCT
              if (data.items != null && data.items!.isNotEmpty)
                productCard(data.items!.first),

              const SizedBox(height: 20),

              /// status of delivery
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: data.currentStatus == "cancelled"
                      ? Colors.red.shade100
                      : Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  data.currentStatus?.toUpperCase() ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              /// TRACKING TIMELINE
              orderTimeline(data),
              const SizedBox(height: 20),

              /// Expected Delivery
              if (data.currentStatus != "delivered" &&
                  data.currentStatus != "cancelled")
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: richText(
                    "Expected Delivery:",
                    data.expectedDelivery ?? "-",
                  ),
                ),

              /// CANCEL REASON
              if (data.isCancelled == true)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Cancelled: ${data.cancelReason}",
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

              const SizedBox(height: 20),

              /// COURIER DETAILS
              courierBox(data),
            ],
          ),
        );
      }),
    );
  }

  Widget productCard(item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey),
      ),
      child: Row(
        children: [
          item.image != null && item.image!.isNotEmpty
              ? Image.network(
                  item.image!,
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                )
              : Container(
                  height: 70,
                  width: 70,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image),
                ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? "",
                  style: text15(fontWeight: FontWeight.bold),
                ),
                Text(item.selectedColor ?? ""),
                Text("₹${item.price}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget orderTimeline(data) {
    final steps = data.trackingSteps;

    if (steps == null) return const SizedBox();

    return Column(
      children: List.generate(steps.length, (index) {
        final step = steps[index];

        IconData icon;

        switch (step.status) {
          case "confirmed":
            icon = Icons.check_circle;
            break;

          case "shipped":
            icon = Icons.local_shipping;
            break;

          case "out_for_delivery":
            icon = Icons.delivery_dining;
            break;

          case "delivered":
            icon = Icons.home;
            break;

          default:
            icon = Icons.circle;
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 16,
              color: step.completed == true ? Colors.green : Colors.grey,
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.label ?? "",
                    style: text14(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    step.description ?? "",
                    style: text11(color: AppColors.textSecondary),
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget courierBox(data) {
    final courier = data.courierDetails;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Courier Details", style: text15(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text("Partner: ${courier?.partner ?? "-"}"),
          Text("Tracking Number: ${courier?.trackingNumber ?? "-"}"),
        ],
      ),
    );
  }
}

Widget richText(String title, String value) {
  return RichText(
    text: TextSpan(
      style: const TextStyle(color: Colors.black),
      children: [
        TextSpan(
          text: title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: value),
      ],
    ),
  );
}
