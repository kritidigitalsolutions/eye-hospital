import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/custom_snakebar.dart';
import 'package:eye_hospital/utils/home_components.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppointmentsPage extends StatelessWidget {
  const MyAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "My Appointments",
                style: text18(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text("Your Upcoming Video Consultation", style: text14()),

              const SizedBox(height: 16),

              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return appointmentCard(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appointmentCard(int index) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.appointmentDetails);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  statusBar(MainAxisAlignment.start),

                  const SizedBox(height: 6),

                  Text(
                    "Dr. Pankaj Tripathi",
                    style: text16(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Eye Specialist",
                    style: text14(fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 8),
                  index != 2
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text("View Details", style: text12()),
                        )
                      : GestureDetector(
                          onTap: () {
                            CustomSnakebar.success(
                              "Downloading",
                              "Download now",
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.textPrimary),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.download, size: 18),
                                SizedBox(width: 5),
                                Text("Download Prescription", style: text12()),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),

            CircleAvatar(
              radius: 36,
              backgroundColor: AppColors.secondary,
              child: CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(AppImages.doctor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
