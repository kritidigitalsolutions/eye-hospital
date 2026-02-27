import 'dart:io';

import 'package:eye_hospital/model/request/auth_request_model/auth_request_model.dart';
import 'package:eye_hospital/repo/auth_repo.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/custom_snakebar.dart';
import 'package:eye_hospital/utils/hive_service/hive_service.dart';
import 'package:eye_hospital/utils/hive_service/userdetail.dart';
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
    sendOtp();
  }

  // ------------------------------------------------------
  // Api
  //--------------------------------------

  final _repo = AuthRepo();

  Future<void> sendOtp() async {
    isLoading.value = true;
    try {
      await _repo.sendOtp(phoneController.text.trim());
      CustomSnakebar.success("Success", "Send Otp successfully");
      Get.toNamed(AppRoutes.otpPage, arguments: phoneController.text.trim());
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

  void validateForm(String phone) {
    genderError.value = selectedGender.value.isEmpty ? "Select gender" : "";

    if (formKey.currentState!.validate() && genderError.value.isEmpty) {
      print("login successfully");
      Get.toNamed(AppRoutes.userImage, arguments: phone);
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

  // ------------------------------------------------------
  // Api
  //--------------------------------------

  final _repo = AuthRepo();
  var isLoading = false.obs;

  Future<void> registerUser(String phone) async {
    isLoading.value = true;
    try {
      final model = UserDetailsReqModel(
        dob: dobController.text.trim(),
        gender: selectedGender.value,
        name: nameController.text.trim(),
        image: profileImage.value?.path,
        phone: phone,
      );
      final res = await _repo.registerUser(model);
      final user = res.user;
      final saveData = UserDetails(
        name: user?.name ?? '',
        dob: user?.birth ?? '',
        gender: user?.gender ?? '',
        token: res.token ?? '',
      );
      print(res.user);
      await HiveService.saveUser(saveData);
      Get.offAllNamed(AppRoutes.homeScreen);
      CustomSnakebar.success("Success", "New Register successful");
    } catch (e) {
      print(e.toString());
      CustomSnakebar.error(
        "Error",
        "Something went wrong. Please try again later",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
