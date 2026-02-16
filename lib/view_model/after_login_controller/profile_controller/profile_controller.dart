import 'dart:io';

import 'package:eye_hospital/utils/custom_snakebar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfileController extends GetxController {
  RxString name = "Amit Kumar".obs;
  RxString mobile = "9876543210".obs;
  RxString gender = "Male".obs;
  Rx<DateTime?> dob = Rx<DateTime?>(null);

  void setGender(String value) {
    gender.value = value;
  }

  void setDob(DateTime value) {
    dob.value = value;
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

  void saveProfile() {
    print("Name: ${name.value}");
    print("Mobile: ${mobile.value}");
    print("Gender: ${gender.value}");
    print("DOB: ${dob.value}");
  }
}
