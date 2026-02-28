import 'dart:io';

import 'package:eye_hospital/model/request/auth_request_model/auth_request_model.dart';
import 'package:eye_hospital/repo/profile_repo.dart';
import 'package:eye_hospital/utils/custom_snakebar.dart';
import 'package:eye_hospital/utils/hive_service/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfileController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController dobCtr = TextEditingController();
  RxString genderCtr = "Male".obs;

  void setGender(String value) {
    genderCtr.value = value;
  }

  RxString name = ''.obs;
  RxString dob = "".obs;
  RxString gender = ''.obs;
  RxString mobile = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserFromHive();
  }

  void loadUserFromHive() {
    final user = HiveService.getUser();

    if (user != null) {
      nameController.text = user.name;
      mobileController.text = user.phone ?? '';
      dobCtr.text = user.dob;
      genderCtr.value = user.gender;

      print("dob---------------------------------------${user.dob}");

      // store

      name.value = user.name;
      mobile.value = user.phone ?? '';
      dob.value = user.dob;
      gender.value = user.gender;

      if (user.image != null && user.image!.isNotEmpty) {
        profileImage.value = File(user.image!);
      }
    }
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dobCtr.text = DateFormat("dd/MM/yyyy").format(picked);
    }
  }

  Rx<File?> profileImage = Rx<File?>(null);

  final ImagePicker picker = ImagePicker();

  /// Ask permission then pick image
  Future<void> pickImageWithPermission(ImageSource source) async {
    Permission permission = source == ImageSource.camera
        ? Permission.camera
        : Permission.photos;

    PermissionStatus status = await permission.request();

    if (status.isGranted) {
      final XFile? image = await picker.pickImage(source: source);

      if (image != null) {
        profileImage.value = File(image.path);
      }
    } else if (status.isDenied) {
      CustomSnakebar.error(
        "Permission Denied",
        "Please allow permission to continue",
      );
    } else if (status.isPermanentlyDenied) {
      CustomSnakebar.error(
        "Permission Required",
        "Please enable permission from settings",
      );
      openAppSettings();
    }
  }

  // ------------------------------------------------------
  // Api
  //--------------------------------------

  final _repo = ProfileRepo();
  var isLoading = false.obs;

  Future<void> editProfile() async {
    isLoading.value = true;
    try {
      final model = UserDetailsReqModel(
        dob: dobCtr.text.trim(),
        gender: gender.value,
        name: nameController.text.trim(),
        image: profileImage.value?.path,
        phone: mobileController.text.trim(),
      );
      await _repo.editProfile(model);

      // update UI from hive
      loadUserFromHive();
      Get.back();

      CustomSnakebar.success("Success", "Profile updated successfully");
    } catch (e) {
      CustomSnakebar.error(
        "Error",
        "Something went wrong. Please try again later",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
