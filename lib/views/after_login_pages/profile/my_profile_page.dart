import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
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

            profileItem("Name", "Amit Kumar"),
            profileItem("Gender", "Male"),
            profileItem("Date of Birth", "12 Feb 1998"),
            profileItem("Mobile", "+91 9876543210"),

            // CustomElevatedIconButton(
            //   title: "Edit Profile",
            //   icon: Icons.edit,
            //   onPressed: () {},
            // ),
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
