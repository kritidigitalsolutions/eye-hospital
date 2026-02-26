import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/view_model/before_login_controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PickProfileImagePage extends StatelessWidget {
  PickProfileImagePage({super.key});

  final RegisterController ctr = Get.find<RegisterController>();
  final phone = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          "Add Profile Image",
          style: text18(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          textButton("Skip", () {
            ctr.registerUser(phone);
          }),
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Text(
                  "Add a profile photo (Optional)",
                  style: text16(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                Obx(
                  () => CircleAvatar(
                    radius: 60,
                    backgroundImage: ctr.profileImage.value != null
                        ? FileImage(ctr.profileImage.value!)
                        : const AssetImage(AppImages.doctor) as ImageProvider,
                  ),
                ),

                const SizedBox(height: 20),

                CustomElevatedIconButton(
                  title: "Pick Image",
                  icon: Icons.camera_alt_outlined,
                  onPressed: () {
                    showPickerSheet();
                  },
                ),

                Obx(
                  () => ctr.profileImage.value != null
                      ? elevatedButton(
                          text: "Continue",

                          background: AppColors.primary,
                          textColor: AppColors.textSecondary,
                          onPressed: () {
                            ctr.registerUser(phone);
                          },
                        )
                      : SizedBox.shrink(),
                ),

                // ElevatedButton.icon(
                //   onPressed: () {
                //     showPickerSheet();
                //   },
                //   icon: const Icon(Icons.camera_alt),
                //   label: const Text("Pick Image"),
                // ),
              ],
            ),
          ),
          Obx(
            () => ctr.isLoading.value
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.black.withAlpha(50),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.secondary,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  void showPickerSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () {
                Get.back();
                ctr.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
              onTap: () {
                Get.back();
                ctr.pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
