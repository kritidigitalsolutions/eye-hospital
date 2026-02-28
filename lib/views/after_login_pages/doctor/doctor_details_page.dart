import 'package:eye_hospital/model/response/doctor_res/doctor_list_res_model.dart';
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
  DoctorProfilePage({super.key});

  final Doctor doctor = Get.arguments;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// MAIN PROFILE CARD
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
                    CircleAvatar(
                      radius: 45,
                      backgroundImage:
                          (doctor.profileImage != null &&
                              doctor.profileImage.toString().isNotEmpty)
                          ? NetworkImage(doctor.profileImage)
                          : const AssetImage(AppImages.doctor) as ImageProvider,
                    ),

                    const SizedBox(height: 8),

                    Text(doctor.name ?? "Unknown Doctor", style: text18()),
                    Text(
                      doctor.specialization ?? "Eye Specialist",
                      style: text12(),
                    ),

                    Text(
                      "⭐ ${doctor.rating ?? 0} (${doctor.totalReviews ?? 0} Reviews)",
                      style: text12(),
                    ),

                    const SizedBox(height: 12),

                    consultationRow(
                      "First Consultation",
                      "₹${doctor.consultationFees?.firstConsultation?.private ?? "--"} (Private)",
                      "₹${doctor.consultationFees?.firstConsultation?.general ?? "--"} (General)",
                    ),

                    consultationRow(
                      "Follow-up Consultation",
                      "₹${doctor.consultationFees?.followUpConsultation?.private ?? "--"} (Private)",
                      "₹${doctor.consultationFees?.followUpConsultation?.general ?? "--"} (General)",
                    ),

                    consultationRow(
                      "Fast Track Consultation",
                      "₹${doctor.consultationFees?.fastTrackConsultation?.standard ?? "--"}",
                      "₹${doctor.consultationFees?.fastTrackConsultation?.followUp ?? "--"} (Follow Up)",
                    ),

                    const SizedBox(height: 16),

                    Text(
                      "About Doctor",
                      style: text14(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      doctor.about ?? "No description available",
                      textAlign: TextAlign.center,
                      style: text11(),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "Qualifications & Experience",
                      style: text14(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),

                    Text(
                      doctor.qualifications.join(", "),
                      textAlign: TextAlign.center,
                      style: text11(),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "${doctor.experienceYears ?? 0} Years Experience",
                      style: text11(),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      doctor.isAvailable == true
                          ? "Available Today"
                          : "Not Available",
                      style: text12(
                        color: doctor.isAvailable == true
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),

                    const SizedBox(height: 12),

                    customOutlineButton(
                      text: "Check Availability",
                      onPressed: () {
                        Get.toNamed(
                          AppRoutes.appointmentPage,
                          arguments: doctor,
                        );
                      },
                    ),

                    const SizedBox(height: 8),

                    elevatedButton(
                      text: "Book Your Appointment",
                      textColor: AppColors.textPrimary,
                      background: AppColors.primary,
                      onPressed: () {
                        Get.toNamed(
                          AppRoutes.appointmentPage,
                          arguments: doctor,
                        );
                      },
                    ),
                  ],
                ),
              ),

              /// OTHER DOCTORS SECTION (outside container)
              const SizedBox(height: 15),
              Text("Check out other Doctors!", style: text16()),
              const SizedBox(height: 10),

              SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return doctorCard(); // make sure this widget exists
                  },
                ),
              ),

              const SizedBox(height: 10),

              customOutlineButton(
                text: "Explore More",
                onPressed: () {
                  Get.back();
                },
              ),

              const SizedBox(height: 50),
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
        children: [
          Expanded(child: Text(title, style: text12())),
          const SizedBox(width: 8),
          const Text("|"),
          const SizedBox(width: 8),
          Expanded(
            child: Text(price, textAlign: TextAlign.center, style: text12()),
          ),
          const SizedBox(width: 8),
          const Text("|"),
          const SizedBox(width: 8),
          Expanded(
            child: Text(time, textAlign: TextAlign.center, style: text11()),
          ),
        ],
      ),
    );
  }
}
