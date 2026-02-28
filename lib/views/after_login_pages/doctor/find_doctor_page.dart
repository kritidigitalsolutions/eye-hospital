import 'package:eye_hospital/data/api_response.dart';
import 'package:eye_hospital/model/response/doctor_res/doctor_list_res_model.dart';
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
                    return _buildLoading();

                  case Status.error:
                    return _buildError(
                      ctr.doctorList.value.message ?? "Something went wrong",
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

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: AppColors.primary),
          const SizedBox(height: 12),
          Text("Loading doctors...", style: text14()),
        ],
      ),
    );
  }

  Widget _buildError(String message) {
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
              onPressed: () {
                ctr.searchDoctor(); // call your API again
              },
              icon: const Icon(Icons.refresh),
              label: const Text("Retry"),
            ),
          ],
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
                    ? NetworkImage(doctor.profileImage)
                    : const AssetImage(AppImages.doctor) as ImageProvider,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
