import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_dimensions.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/home_components.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorProfilePage extends StatelessWidget {
  const DoctorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.primary, AppColors.yellow3],
                  ),
                ),
                child: Column(
                  children: [
                    // Doctor Image
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.secondary,
                          width: 2,
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage(AppImages.doctor),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Name
                    Text("Pankaj Tripathi", style: text18()),

                    Text("Eye Specialist (Ophthalmologist)", style: text12()),

                    const SizedBox(height: 4),

                    Text("⭐ 4.8 Rating", style: text12()),

                    const SizedBox(height: 12),

                    // Consultation Cards
                    consultationRow(
                      "First Consultation",
                      "Rs 300/-\n(Private)",
                      "Rs 200/-\n(General)",
                    ),
                    consultationRow(
                      "Follow-up Consultation",
                      "Rs 300/-\n(Private)",
                      "Rs 200/-\n(General)",
                    ),
                    consultationRow(
                      "Fast Track Consultation",
                      "Rs 1000/-",
                      "Rs 600/-\n(Follow Up)",
                    ),

                    const SizedBox(height: 16),

                    // About Doctor
                    const Text(
                      "About Doctor",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Dr. Pankaj Tripathi is an experienced eye specialist "
                      "providing comprehensive diagnosis and treatment "
                      "for various eye conditions with a patient-first approach.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),

                    const SizedBox(height: 12),

                    // Qualifications
                    const Text(
                      "Qualifications & Experience",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "MBBS\nMS (Opthalmology)",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),

                    const SizedBox(height: 12),

                    // Buttons
                    customOutlineButton(
                      text: "Check Availability",
                      onPressed: () {
                        Get.toNamed(AppRoutes.appointmentPage);
                      },
                    ),

                    const SizedBox(height: 8),

                    elevatedButton(
                      text: "Book Your Appointment",
                      textColor: AppColors.textPrimary,
                      background: AppColors.primary,
                      onPressed: () {
                        Get.toNamed(AppRoutes.appointmentPage);
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),

              Text("Check out other Doctors!", style: text16()),

              const SizedBox(height: 10),

              // Other Doctors List
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return doctorCard();
                    },
                  ),
                ),
              ),

              const SizedBox(height: 10),

              customOutlineButton(
                text: "Explore More",
                onPressed: () {
                  Get.back();
                },
              ),

              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget consultationRow(String title, String price, String time) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Text(title, style: const TextStyle(fontSize: 12))),
          SizedBox(width: 8),
          Text(
            "|",
            style: text16(fontWeight: FontWeight.bold).copyWith(height: 1.2),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              textAlign: TextAlign.center,
              price,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          SizedBox(width: 8),
          Text("|"),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              time,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}
