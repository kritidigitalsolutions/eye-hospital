import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_dimensions.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget doctorCard() {
  return GestureDetector(
    onTap: () {
      Get.toNamed(AppRoutes.doctorDetails);
    },
    child: Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // ✅ FIX
        children: [
          CircleAvatar(
            radius: 28, // slightly smaller
            backgroundImage: AssetImage(AppImages.femaleDoctor),
          ),
          const SizedBox(height: 6),
          Text("Dr. Smith", style: text12(fontWeight: FontWeight.bold)),
          Text("Eye Specialist", style: text10(color: AppColors.grey)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppDimensions.radius15),
            ),
            child: Center(
              child: Text(
                "See Profile",
                style: text10(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget statusBar(MainAxisAlignment place) {
  return Row(
    mainAxisAlignment: place,
    children: [
      Text("Status: Confirmed", style: TextStyle(fontSize: 12)),
      SizedBox(width: 6),
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: AppColors.success,
          shape: BoxShape.circle,
        ),
      ),
    ],
  );
}
