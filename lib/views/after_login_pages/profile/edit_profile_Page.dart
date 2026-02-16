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

  final EditProfileController ctr = Get.put(EditProfileController());

  final TextEditingController nameController = TextEditingController(
    text: "Amit Kumar",
  );
  final TextEditingController mobileController = TextEditingController(
    text: "9876543210",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
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
              controller: nameController,
              hintText: "Full Name",
            ),

            const SizedBox(height: 14),

            /// Mobile
            AbsorbPointer(
              child: CustomTextFieldWithBorder(
                controller: mobileController,
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
                    value: ctr.gender.value,
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
            Obx(
              () => InkWell(
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                  );

                  if (picked != null) {
                    ctr.setDob(picked);
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.grey),
                  ),
                  child: Text(
                    ctr.dob.value == null
                        ? "Select Date of Birth"
                        : "${ctr.dob.value!.day}-${ctr.dob.value!.month}-${ctr.dob.value!.year}",
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Save Button
            CustomButton(title: "Save Changes", onPressed: () {}),
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
              ctr.pickImageWithPermission(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text("Gallery"),
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
