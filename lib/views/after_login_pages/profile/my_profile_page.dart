import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/view_model/after_login_controller/profile_controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfilePage extends StatelessWidget {
  MyProfilePage({super.key});

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
        title: Text("My Profile", style: text18(color: AppColors.black)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.grey.shade300,
            child: customIconButton(
              icon: Icons.edit,
              onPressed: () {
                Get.toNamed(AppRoutes.editProfile);
              },
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Image
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Obx(
              () => Column(
                children: [
                  profileItem("Name", ctr.name.value),
                  profileItem("Gender", ctr.gender.value),
                  profileItem("Date of Birth", ctr.dob.value),
                  profileItem("Mobile", ctr.mobile.value),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileItem(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: text14(color: AppColors.textSecondary)),
          ),
          Text(value, style: text15(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
