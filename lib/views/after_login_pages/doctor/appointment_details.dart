import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/home_components.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentDetailPage extends StatelessWidget {
  const AppointmentDetailPage({super.key});

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

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.yellow3],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    statusBar(MainAxisAlignment.end),

                    const SizedBox(height: 12),

                    CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage(AppImages.doctor),
                    ),

                    const SizedBox(height: 8),

                    header("Dr. Pankaj Tripathi"),
                    subHeader("Eye Specialist"),

                    const SizedBox(height: 12),

                    header("Appointment Type"),
                    subHeader("Video Consultation"),

                    const SizedBox(height: 12),

                    header("Date & Time"),
                    subHeader("25 Jan 2025 | 11:30 AM"),

                    const SizedBox(height: 16),

                    // Join Button
                    CustomElevatedIconButton(
                      title: "Join Video Call",
                      icon: Icons.video_call,
                      onPressed: () {
                        Get.toNamed(AppRoutes.videoCall);
                      },
                    ),

                    const SizedBox(height: 12),

                    // Reschedule Button
                    customOutlineButton(text: "Reschedle", onPressed: () {}),

                    const SizedBox(height: 12),

                    // Cancel Button
                    elevatedButton(
                      text: "Cancel Appointment",
                      onPressed: () {},

                      background: AppColors.error,
                      textColor: AppColors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Header text widget
  Widget header(String text) {
    return Text(
      text,
      style: text16(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
    );
  }

  /// SubHeader text widget
  Widget subHeader(String text) {
    return Text(
      text,
      style: text14(
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
    );
  }
}
