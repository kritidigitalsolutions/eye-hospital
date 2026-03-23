import 'package:eye_hospital/data/api_response.dart';
import 'package:eye_hospital/model/response/doctor_res/doctor_list_res_model.dart';
import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_dimensions.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/custom_textfields.dart';
import 'package:eye_hospital/utils/home_components.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/view_model/after_login_controller/doctor_controller/doctor_controlles.dart';
import 'package:eye_hospital/views/shimmer_widget/shimmer_widget.dart';
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
            children: [
              Text("Find Eye Doctors", style: text20()),
              const SizedBox(height: 12),

              CustomTextFieldWithBorder(
                controller: ctr.searchDoctorCtr,
                hintText: "Search Doctor",
                borderRadius: AppDimensions.radiusExtraLarge,
                prefixIcon: Icons.search,
                onChanged: (value) {
                  ctr.filterDoctors(value);
                },
              ),

              const SizedBox(height: 16),
              Obx(() {
                final status = ctr.doctorList.value.status;

                switch (status) {
                  case Status.loading:
                    return buildShimmerList();

                  case Status.error:
                    return buildError(
                      ctr.doctorList.value.message ?? "Something went wrong",
                      () {
                        ctr.searchDoctor();
                      },
                    );

                  case Status.completed:
                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await ctr.refreshDoctors(); // 🔄 pull to refresh
                        },
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: ctr.filteredDoctors.length,
                          itemBuilder: (context, index) {
                            final doctor = ctr.filteredDoctors[index];
                            return doctorCard(doctor);
                          },
                        ),
                      ),
                    );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget doctorCard(Doctor doctor) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.doctorDetails,
          arguments: doctor, // pass doctor object
        );
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
            /// Left Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctor.name ?? "Unknown Doctor", style: text16()),
                  const SizedBox(height: 4),
                  Text(doctor.specialization ?? "Specialist", style: text12()),
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

            /// Right Image
            CircleAvatar(
              radius: 36,
              backgroundColor: AppColors.grey,
              child: CircleAvatar(
                radius: 35,
                backgroundColor: AppColors.white,
                backgroundImage:
                    (doctor.profileImage != null &&
                        doctor.profileImage.toString().isNotEmpty)
                    ? NetworkImage(doctor.profileImage ?? '')
                    : const AssetImage(AppImages.doctor) as ImageProvider,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
