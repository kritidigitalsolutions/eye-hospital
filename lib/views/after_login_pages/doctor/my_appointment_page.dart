import 'package:cached_network_image/cached_network_image.dart';
import 'package:eye_hospital/data/api_response.dart';
import 'package:eye_hospital/model/response/doctor_res/appointment_res_model.dart';
import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/custom_snakebar.dart';
import 'package:eye_hospital/utils/home_components.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/view_model/after_login_controller/doctor_controller/doctor_controlles.dart';
import 'package:eye_hospital/views/shimmer_widget/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppointmentsPage extends StatelessWidget {
  MyAppointmentsPage({super.key});

  final MyAppOintmentController ctr = Get.put(MyAppOintmentController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return; // agar already pop ho chuka hai to kuch mat karo

        Get.offAllNamed(AppRoutes.homeScreen); // 👈 Home page par redirect
      },
      child: Scaffold(
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
                Text("Your Upcoming Physical Consultation", style: text14()),

                const SizedBox(height: 16),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        filterChip("all", ctr.totalCount),
                        filterChip("cancelled", ctr.countByStatus("cancelled")),
                        filterChip("confirmed", ctr.countByStatus("confirmed")),
                        filterChip("pending", ctr.countByStatus("pending")),
                        filterChip("completed", ctr.countByStatus("completed")),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                Expanded(
                  child: Obx(() {
                    final response = ctr.myAppointment.value;

                    switch (response.status) {
                      case Status.loading:
                        return buildShimmerList();

                      case Status.error:
                        return Center(
                          child: Text(
                            response.message ?? "Something went wrong",
                          ),
                        );

                      case Status.completed:
                        final appointments = ctr.filteredAppointments;

                        if (appointments.isEmpty) {
                          return const Center(
                            child: Text("No appointments found"),
                          );
                        }

                        return ListView.builder(
                          itemCount: appointments.length,
                          itemBuilder: (context, index) {
                            return appointmentCard(appointments[index]);
                          },
                        );
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appointmentCard(Appointment item) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.appointmentDetails, arguments: item);
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
                  /// Status
                  statusBar(
                    MainAxisAlignment.start,
                    item.status?.capitalize ?? '',
                  ),

                  const SizedBox(height: 6),

                  /// Doctor Name
                  Text(
                    item.doctor?.name ?? "N/A",
                    style: text16(fontWeight: FontWeight.bold),
                  ),

                  /// Specialization
                  Text(
                    item.doctor?.specialization ?? "",
                    style: text14(fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 8),

                  /// Button
                  item.prescription == null
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
                              "Prescription download started",
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
                                const Icon(Icons.download, size: 18),
                                const SizedBox(width: 5),
                                Text("Download Prescription", style: text12()),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),

            /// Doctor Image
            CircleAvatar(
              radius: 36,
              backgroundColor: AppColors.grey.shade300,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: item.doctor?.profileImage ?? "",
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(strokeWidth: 1),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.person),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filterChip(String status, int count) {
    return Obx(() {
      final isSelected = ctr.selectedStatus.value == status;

      return GestureDetector(
        onTap: () {
          ctr.selectedStatus.value = status;
        },
        child: Container(
          margin: EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary
                : AppColors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                status.capitalizeFirst!,
                style: text12(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(width: 6),
              CircleAvatar(
                radius: 10,
                backgroundColor: isSelected
                    ? AppColors.white
                    : AppColors.primary,
                child: Text(
                  count.toString(),
                  style: text10(
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
