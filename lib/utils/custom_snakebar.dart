import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnakebar {
  /// ✅ Success Snackbar
  static void success(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.success,
      colorText: AppColors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(AppDimensions.padding12),
      icon: const Icon(Icons.check_circle, color: AppColors.white),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  /// ❌ Error Snackbar
  static void error(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.error,
      colorText: AppColors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(AppDimensions.padding12),
      icon: const Icon(Icons.error, color: AppColors.white),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
