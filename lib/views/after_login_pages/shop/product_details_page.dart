import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/view_model/after_login_controller/shop_controller/product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({super.key});

  final data = Get.arguments;

  final controller = Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    print(data);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          "Product Details",
          style: text16(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
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
                  Image.asset(data["image"], height: 120),
                  const SizedBox(height: 8),
                  Text(
                    data["title"],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  /// Icons row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(FontAwesomeIcons.cartPlus, size: 20),
                      SizedBox(width: 16),
                      Icon(Icons.favorite_border, size: 23),
                      SizedBox(width: 16),
                      Icon(Icons.share, size: 23),
                    ],
                  ),

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
                      data['price'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// Available Colors
            const Text(
              "Available Colors",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ColorChip("Black", 0),
                ColorChip("Brown", 1),
                ColorChip("Transparent", 2),
              ],
            ),

            const SizedBox(height: 16),

            /// Product Highlights
            sectionTitle("Product Highlights"),
            const SizedBox(height: 8),
            highlightText("Lightweight & durable design"),
            highlightText("Comfortable for daily wear"),
            highlightText("Suitable for all face shapes"),
            highlightText("Premium quality material"),

            const SizedBox(height: 16),

            /// Frame Details
            sectionTitle("Frame Details"),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: frameRow("Frame Type", "Full Rim")),
                Expanded(child: frameRow("Frame Size", "Medium")),
                Expanded(child: frameRow("Frame Shape", "Rectangle")),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: frameRow("Gender", "Unisex")),
                Expanded(child: frameRow("Frame Material", "Acetate")),
                Expanded(child: SizedBox(width: 25)),
              ],
            ),

            const SizedBox(height: 20),

            /// Buy Now Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                elevatedButton(
                  text: "Buy Now",
                  background: AppColors.buttonPrimary,
                  textColor: AppColors.textPrimary,
                  onPressed: () {
                    Get.toNamed(AppRoutes.checkoutPage);
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// Care Instructions
            sectionTitle("Care Instructions"),
            highlightText("Clean with microfiber cloth"),
            highlightText("Avoid heat exposure"),
            highlightText("Store in protective case"),

            const SizedBox(height: 16),

            /// Customer Reviews
            sectionTitle("Customer Reviews"),
            const SizedBox(height: 8),
            Column(children: List.generate(6, (index) => reviewCard())),
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
          Text(text),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primary.withAlpha(100),
            radius: 30,
            child: Text(
              "R",
              style: text16(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          const SizedBox(width: 8),

          /// Wrap Column with Expanded to avoid overflow
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Name
                Text(
                  "Radhika",
                  style: text16(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 2),

                /// ⭐ Stars row
                Row(
                  children: List.generate(
                    5,
                    (index) => const Icon(
                      Icons.star,
                      size: 14,
                      color: AppColors.orange,
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                /// Review text
                Text(
                  "Very comfortable and stylish frame. Value for money.",
                  style: text12(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
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
  final int index;
  final ProductDetailsController controller = Get.find();

  ColorChip(this.text, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedCategory.value == index;

      return GestureDetector(
        onTap: () {
          controller.selectedCategory.value = index;
        },
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppColors.white : AppColors.grey,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isSelected ? AppColors.black : AppColors.grey.shade700,
            ),
          ),
        ),
      );
    });
  }
}
