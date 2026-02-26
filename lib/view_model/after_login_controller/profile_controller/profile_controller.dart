import 'dart:io';

import 'package:eye_hospital/model/request/auth_request_model/auth_request_model.dart';
import 'package:eye_hospital/repo/profile_repo.dart';
import 'package:eye_hospital/utils/custom_snakebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfileController extends GetxController {
  final TextEditingController nameController = TextEditingController(
    text: "Amit Kumar",
  );
  final TextEditingController mobileController = TextEditingController(
    text: "9876543210",
  );

  final TextEditingController dob = TextEditingController(text: "12/01/2003");

  RxString gender = "Male".obs;

  void setGender(String value) {
    gender.value = value;
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dob.text = DateFormat("dd/MM/yyyy").format(picked);
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

  Future<void> registerUser() async {
    try {
      final model = UserDetailsReqModel(
        dob: dob.text.trim(),
        gender: gender.value,
        name: nameController.text.trim(),
        image: profileImage.value?.path,
        phone: mobileController.text.trim(),
      );
      await _repo.editProfile(model);
      CustomSnakebar.success("Success", "Profile updated successfully");
    } catch (e) {
      CustomSnakebar.error(
        "Error",
        "Something went wrong. Please try again later",
      );
    }
  }
}
