import 'package:eye_hospital/repo/auth_repo.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/custom_snakebar.dart';
import 'package:eye_hospital/utils/hive_service/hive_service.dart';
import 'package:eye_hospital/utils/hive_service/userdetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final isLoading = false.obs;

  final List<TextEditingController> otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  void onOtpChanged(String value, int index) {
    if (value.length == 1) {
      if (index < 5) {
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

  void submitOtp(String phone) {
    String otp = otpControllers.map((e) => e.text).join();
    if (otp.length < 6) {
      CustomSnakebar.error("Error", "Please enter complete OTP");
      return;
    }

    verifyOtp(phone, otp);
  }

  // ------------------------------------------------------
  // Api
  //--------------------------------------

  final _repo = AuthRepo();

  Future<void> verifyOtp(String phone, String otp) async {
    isLoading.value = true;
    try {
      final res = await _repo.verfiyOtp(phone, otp);

      final isNewUser = res["isNewUser"];
      if (isNewUser) {
        CustomSnakebar.success("Success", "OTP Verified Successfully");
        Get.toNamed(AppRoutes.registerPage, arguments: phone);
      } else {
        // ✅ save user & token
        final userJson = res["user"];
        final token = res["token"]; // if backend sends token

        final user = UserDetails(
          name: userJson["name"],
          dob: userJson["dob"],
          gender: userJson["gender"],
          token: token,
          phone: phone,
        );

        await HiveService.saveUser(user);

        CustomSnakebar.success("Success", "Login Successfully");

        // ✅ remove OTP screen from stack
        Get.offAllNamed(AppRoutes.homeScreen);
      }
    } catch (e) {
      CustomSnakebar.error(
        "Error",
        "Something went wrong. Please try again later",
      );
    } finally {
      isLoading.value = false;
    }
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
