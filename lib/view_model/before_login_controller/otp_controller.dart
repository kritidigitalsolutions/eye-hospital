import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/custom_snakebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final isLoading = false.obs;

  final List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  void onOtpChanged(String value, int index) {
    if (value.length == 1) {
      if (index < 3) {
        focusNodes[index + 1].requestFocus();
      }
    } else if (value.isEmpty) {
      // Yeh tab trigger hota hai jab backspace se delete kiya
      if (index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    }
  }

  // Backspace ko handle karne ka behtar tareeka
  void handleBackspace(int index) {
    if (otpControllers[index].text.isNotEmpty) {
      // Current mein value hai → bas clear kar denge (onChanged call hoga)
      otpControllers[index].clear();
    } else if (index > 0) {
      // Current khali hai → previous ko clear + focus
      otpControllers[index - 1].clear();
      focusNodes[index - 1].requestFocus();
    } else if (index > 0 && otpControllers[index].text.isNotEmpty) {
      otpControllers[index - 1].clear();
      focusNodes[index - 1].requestFocus();
    }
  }

  void submitOtp() {
    String otp = otpControllers.map((e) => e.text).join();
    if (otp.length < 4) {
      CustomSnakebar.error("Error", "Please enter complete OTP");
      return;
    }

    isLoading.value = true;

    // API call yahan daal dena
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      CustomSnakebar.success("Success", "OTP Verified Successfully");
      Get.toNamed(AppRoutes.registerPage);
    });
  }

  @override
  void onClose() {
    for (var c in otpControllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.onClose();
  }
}
