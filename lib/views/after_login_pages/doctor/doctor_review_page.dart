import 'package:eye_hospital/model/response/doctor_res/doctor_list_res_model.dart';
import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_dimensions.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repo/doctor_repo.dart';

class DoctorReviewPage extends StatefulWidget {
  const DoctorReviewPage({super.key});

  @override
  State<DoctorReviewPage> createState() => _DoctorReviewPageState();
}

class _DoctorReviewPageState extends State<DoctorReviewPage> {
  final Doctor doctor = Get.arguments as Doctor;
  final TextEditingController reviewController = TextEditingController();
  int selectedRating = 0;
  final DoctorRepo _repo = DoctorRepo();
  bool _isLoading = false;

  Future<void> _submitDoctorReview() async {
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
      final body = {
        "rating": selectedRating.toString(),
        "comment": reviewController.text.trim(),
      };

      print("Doctor ID: ${doctor.id}");
      print("Submitting Doctor Review Data: $body");

      final res = await _repo.submitDoctorReview(doctor.id!, body);

      print("Doctor Review Response: $res");

      if (res['success'] == true) {
        Get.back();
        Get.snackbar("Success", res['message'] ?? "Review submitted successfully!");
      } else {
        Get.snackbar("Notice", res['message'] ?? "Failed to submit review");
      }
    } catch (e) {
      print("Doctor Review Submission Error: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text("Rate & Review Doctor", style: text16(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Doctor Brief
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: (doctor.profileImage != null && doctor.profileImage.toString().isNotEmpty)
                      ? NetworkImage(doctor.profileImage)
                      : const AssetImage(AppImages.doctor) as ImageProvider,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.name ?? "Unknown Doctor",
                        style: text14(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        doctor.specialization ?? "Eye Specialist",
                        style: text12(color: AppColors.grey),
                      ),
                    ],
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
                hintText: "How was your experience with Dr. ${doctor.name}?",
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
                    onPressed: _submitDoctorReview,
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
