import 'package:eye_hospital/utils/custom_snakebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../repo/support_repo.dart';

class SupportController extends GetxController {
  final SupportRepo _repo = SupportRepo();

  final TextEditingController queryController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  var isLoading = false.obs;

  void clear() {
    queryController.clear();
    feedbackController.clear();
  }

  Future<void> submitQuery() async {
    /// Validation
    if (queryController.text.trim().isEmpty) {
      CustomSnakebar.error("Error", "Please enter your query");
      return;
    }

    if (feedbackController.text.trim().isEmpty) {
      CustomSnakebar.error("Error", "Please enter your feedback");
      return;
    }

    try {
      isLoading.value = true;

      final res = await _repo.sendSupportQuery(
        queryController.text.trim(),
        feedbackController.text.trim(),
      );

      if (res['success'] == true) {
        Get.back();
        clear();
        CustomSnakebar.success(
          "Success",
          "Your support request has been submitted successfully. Our team will get back to you soon.",
        );
      } else {
        CustomSnakebar.success(
          "Error",
          "Unable to submit your request at the moment. Please try again later.",
        );
      }
    } catch (e) {
      CustomSnakebar.error("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
