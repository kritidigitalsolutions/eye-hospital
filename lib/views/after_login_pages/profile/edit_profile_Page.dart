import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/custom_textfields.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/view_model/after_login_controller/profile_controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});

  final ctr = Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        shadowColor: AppColors.grey.shade100,
        title: Text("Edit Profile", style: text18(color: AppColors.black)),
        centerTitle: true,

        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Profile Image
            Center(
              child: Obx(
                () => Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundImage: ctr.profileImage.value != null
                          ? FileImage(ctr.profileImage.value!)
                          : const AssetImage(AppImages.doctor) as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => showImagePickerSheet(ctr),
                        child: const CircleAvatar(
                          radius: 18,
                          child: Icon(Icons.camera_alt, size: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Name
            CustomTextFieldWithBorder(
              controller: ctr.nameController,
              hintText: "Full Name",
            ),

            const SizedBox(height: 14),

            /// Mobile
            AbsorbPointer(
              child: CustomTextFieldWithBorder(
                controller: ctr.mobileController,
                hintText: "Mobile Number",
              ),
            ),

            const SizedBox(height: 14),

            /// Gender Dropdown
            Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.grey),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: ctr.genderCtr.value,
                    isExpanded: true,
                    items: ["Male", "Female", "Other"]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) {
                      ctr.setGender(val!);
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            /// DOB Picker
            /// DOB
            CustomTextFieldWithBorder(
              controller: ctr.dobCtr,
              hintText: "Date of birth",
              readOnly: true,
              onTap: () => ctr.selectDate(context),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please select your date of birth";
                }
                return null;
              },
            ),

            const SizedBox(height: 30),

            /// Save Button
            Obx(
              () => CustomButton(
                title: "Save Changes",
                isLoading: ctr.isLoading.value,
                onPressed: () {
                  ctr.editProfile();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showImagePickerSheet(EditProfileController ctr) {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: Text("Camera", style: text15(fontWeight: FontWeight.bold)),
            onTap: () {
              Get.back();
              ctr.pickImageWithPermission(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: Text("Gallery", style: text15(fontWeight: FontWeight.bold)),
            onTap: () {
              Get.back();
              ctr.pickImageWithPermission(ImageSource.gallery);
            },
          ),
        ],
      ),
    ),
  );
}
