import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_dimensions.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../model/response/doctor_res/doctor_list_res_model.dart';

Widget doctorCard(Doctor doctor) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(AppRoutes.doctorDetails, arguments: doctor);
    },
    child: Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage:
                (doctor.profileImage != null &&
                    doctor.profileImage!.isNotEmpty &&
                    doctor.profileImage != "null")
                ? NetworkImage(doctor.profileImage!)
                : const AssetImage(AppImages.femaleDoctor) as ImageProvider,
          ),

          const SizedBox(height: 6),

          /// Name
          Text(
            doctor.name ?? "N/A",
            style: text12(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          /// Specialization
          Text(
            doctor.specialization ?? "",
            style: text10(color: AppColors.grey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),

          /// Button
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

class EmptyStateWidget extends StatelessWidget {
  final String animation;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback? onTap;
  final double height;

  const EmptyStateWidget({
    super.key,
    required this.animation,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    this.onTap,
    this.height = 300,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),

        /// Animation
        Lottie.asset(animation, height: height),

        const SizedBox(height: 20),

        /// Title
        Text(
          title,
          style: text16(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 6),

        /// Subtitle
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: text12(color: AppColors.textSecondary),
        ),

        const SizedBox(height: 20),

        /// Button (optional)
        if (onTap != null)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonPrimary,
            ),
            onPressed: onTap,
            child: Text(buttonText, style: text14()),
          ),
      ],
    );
  }
}

Widget statusBar(MainAxisAlignment place, String? status) {
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return AppColors.greenGr1;
      case "pending":
        return AppColors.warning;
      case "cancelled":
        return AppColors.error;
      case "confirmed":
        return AppColors.secondary;
      default:
        return AppColors.grey;
    }
  }

  final color = getStatusColor(status ?? "");

  return Row(
    mainAxisAlignment: place,
    children: [
      Text(
        "Status: ${status ?? "N/A"}",
        style: text12(
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      const SizedBox(width: 6),
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    ],
  );
}

Widget buildError(String message, VoidCallback onTap) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 60),
          const SizedBox(height: 12),
          Text("Oops!", style: text18(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: text14(color: AppColors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: onTap,
            icon: const Icon(Icons.refresh),
            label: Text("Retry", style: text14(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    ),
  );
}
