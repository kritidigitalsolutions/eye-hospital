import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_dimensions.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/response/doctor_res/doctor_list_res_model.dart';


Widget doctorCard() {
  return GestureDetector(
    onTap: () {
      final dummyDoctor = Doctor(
        id: "dummy_dr_id",
        name: "Dr. Smith",
        specialization: "Eye Specialist",
        profileImage: null,
        rating: 5,
        totalReviews: 120,
        about: "Dr. Smith is a renowned Eye Specialist with over 10 years of experience in ophthalmology.",
        qualifications: ["MBBS", "MS - Ophthalmology"],
        experienceYears: 10,
        consultationFees: ConsultationFees(
          firstConsultation: Consultation(private: 500, general: 300),
          followUpConsultation: Consultation(private: 300, general: 200),
          fastTrackConsultation: FastTrackConsultation(standard: 800, followUp: 500),
        ),
        availableDays: ["Monday", "Wednesday", "Friday"],
        availableTimeSlots: ["10:00 AM", "02:00 PM"],
        isAvailable: true,
      );

      Get.toNamed(
        AppRoutes.doctorDetails,
        arguments: dummyDoctor,
      );
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
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 28,
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


// Widget doctorCard() {
//   return GestureDetector(
//     onTap: () {
//       Get.toNamed(AppRoutes.doctorDetails);
//     },
//     child: Container(
//       width: 120,
//       margin: const EdgeInsets.only(right: 12),
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: AppColors.grey.shade200,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min, // ✅ FIX
//         children: [
//           CircleAvatar(
//             radius: 28, // slightly smaller
//             backgroundImage: AssetImage(AppImages.femaleDoctor),
//           ),
//           const SizedBox(height: 6),
//           Text("Dr. Smith", style: text12(fontWeight: FontWeight.bold)),
//           Text("Eye Specialist", style: text10(color: AppColors.grey)),
//           const SizedBox(height: 4),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
//             decoration: BoxDecoration(
//               color: AppColors.primary,
//               borderRadius: BorderRadius.circular(AppDimensions.radius15),
//             ),
//             child: Center(
//               child: Text(
//                 "See Profile",
//                 style: text10(),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

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
