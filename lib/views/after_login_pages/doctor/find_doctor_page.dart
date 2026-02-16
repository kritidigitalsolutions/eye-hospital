import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_dimensions.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/custom_textfields.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/view_model/after_login_controller/doctor_controller/doctor_controlles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindDoctorsPage extends StatelessWidget {
  FindDoctorsPage({super.key});

  final ctr = Get.put(FindDoctorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text("Find Eye Doctors", style: text20()),

              const SizedBox(height: 12),

              // Search Bar
              CustomTextFieldWithBorder(
                controller: ctr.searchDoctorCtr,
                hintText: "Search Doctor",
                borderRadius: AppDimensions.radiusExtraLarge,
                prefixIcon: Icons.search,
              ),

              const SizedBox(height: 16),

              // List
              Expanded(
                child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return doctorCard();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget doctorCard() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.doctorDetails);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.yellow3],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          children: [
            // Left Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Pankaj Tripathi", style: text16()),
                  const SizedBox(height: 4),
                  Text("Eye Specialist", style: text12()),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.buttonPrimary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "See Profile",
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),

            // Right Image
            CircleAvatar(
              radius: 36,
              backgroundColor: AppColors.grey,
              child: CircleAvatar(
                radius: 35,
                backgroundColor: AppColors.white,
                child: Image.asset(AppImages.doctor, fit: BoxFit.contain),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
