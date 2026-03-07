import 'package:eye_hospital/model/response/product_res/product_res_model.dart';
import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_dimensions.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repo/product_repo.dart';

class ProductReviewPage extends StatefulWidget {
  const ProductReviewPage({super.key});

  @override
  State<ProductReviewPage> createState() => _ProductReviewPageState();
}

class _ProductReviewPageState extends State<ProductReviewPage> {
  final Product product = Get.arguments as Product;
  final TextEditingController reviewController = TextEditingController();
  int selectedRating = 0;
  final ProductRepo _repo = ProductRepo();
  bool _isLoading = false;

  Future<void> _submitProductReview() async {
    if (selectedRating == 0) {
      Get.snackbar("Error", "Please select a rating");
      return;
    }
    if (reviewController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please write a comment");
      return;
    }
    setState(() => _isLoading = true);
    try {
      Map<String, dynamic> body = {
        "rating": selectedRating.toString(),
        "comment": reviewController.text.trim(),
      };
      print("Product ID: ${product.id}");
      print("Review Body: $body");

      final res = await _repo.submitProductReview(product.id!, body);

      if (res != null && res['success'] == true) {
        Get.back();
        Get.snackbar("Success", res['message'] ?? "Review submitted successfully");
      } else {
        Get.snackbar("Notice", res['message'] ?? "Failed to submit review");
      }
    } catch (e) {
      print("Review Error: $e");
      Get.snackbar("Error", "Something went wrong");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text("Rate & Review", style: text16(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Brief
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: product.images.isNotEmpty
                      ? Image.network(
                          product.images.first,
                          errorBuilder: (_, __, ___) => const Icon(Icons.image),
                        )
                      : const Icon(Icons.image),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    product.name ?? "",
                    style: text14(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// Star Rating
            sectionTitle("Rating"),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      selectedRating = index + 1;
                    });
                  },
                  icon: Icon(
                    index < selectedRating ? Icons.star : Icons.star_border,
                    color: Colors.orange,
                    size: 35,
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),

            /// Write Review
            sectionTitle("Write your review"),
            const SizedBox(height: 8),
            TextField(
              controller: reviewController,
              maxLines: 5,
              maxLength: 500,
              decoration: InputDecoration(
                hintText: "Share your experience with this product...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radius15),
                ),
              ),
            ),

            const SizedBox(height: 30),

            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
                    title: "Submit Review",
                    onPressed: _submitProductReview,
                  ),
          ],
        ),
      ),
    );
  }

  static Widget sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    );
  }
}
