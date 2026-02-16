import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/custom_snakebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var isLoading = false.obs;

  void submit() {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      Future.delayed(const Duration(seconds: 2), () {
        isLoading.value = false;
        CustomSnakebar.success("Success", "OTP Sent Successfully");
      });

      Get.toNamed(AppRoutes.otpPage);
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var selectedGender = "".obs;

  var nameError = "".obs;
  var dobError = "".obs;
  var genderError = "".obs;

  void selectGender(String gender) {
    selectedGender.value = gender;
    genderError.value = "";
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dobController.text = DateFormat("dd/MM/yyyy").format(picked);
      dobError.value = "";
    }
  }

  void validateForm() {
    genderError.value = selectedGender.value.isEmpty ? "Select gender" : "";

    if (formKey.currentState!.validate() && genderError.value.isEmpty) {
      print("login successfully");
      CustomSnakebar.success("Success", "Form Submitted");
      Get.toNamed(AppRoutes.homeScreen);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    dobController.dispose();
    super.onClose();
  }
}
