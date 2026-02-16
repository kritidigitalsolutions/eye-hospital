import 'dart:io';

import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/custom_snakebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

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
      Get.toNamed(AppRoutes.userImage);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    dobController.dispose();
    super.onClose();
  }

  // image select

  Rx<File?> profileImage = Rx<File?>(null);

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    Permission permission = source == ImageSource.camera
        ? Permission.camera
        : Permission.photos;

    var status = await permission.request();

    if (status.isGranted) {
      final XFile? image = await picker.pickImage(source: source);
      if (image != null) {
        profileImage.value = File(image.path);
      }
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
