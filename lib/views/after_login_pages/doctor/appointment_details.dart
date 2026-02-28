import 'package:eye_hospital/model/response/doctor_res/appointment_res_model.dart';
import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/home_components.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/view_model/after_login_controller/doctor_controller/doctor_controlles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppointmentDetailPage extends StatelessWidget {
  AppointmentDetailPage({super.key});

  final Appointment appointment = Get.arguments;

  final MyAppOintmentController ctr = Get.find();

  String formatDate(DateTime? date) {
    if (date == null) return "N/A";
    return DateFormat("dd MMM yyyy").format(date);
  }

  @override
  Widget build(BuildContext context) {
    print(appointment);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "My Appointment",
                style: text18(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text("Appointment Details", style: text14()),

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
                    /// Status
                    statusBar(MainAxisAlignment.end, appointment.status ?? ""),

                    const SizedBox(height: 12),

                    /// Doctor Image
                    CircleAvatar(
                      radius: 45,
                      backgroundImage: appointment.doctor?.profileImage != null
                          ? NetworkImage(appointment.doctor!.profileImage!)
                          : const AssetImage("assets/images/doctor.png")
                                as ImageProvider,
                    ),

                    const SizedBox(height: 8),

                    /// Doctor Name
                    header(appointment.doctor?.name ?? "N/A"),
                    subHeader(appointment.doctor?.specialization ?? "N/A"),

                    const SizedBox(height: 12),

                    /// Appointment Type
                    header("Appointment Type"),
                    subHeader(appointment.appointmentType ?? "N/A"),

                    const SizedBox(height: 12),

                    /// Date & Time
                    header("Date & Time"),
                    subHeader(
                      "${formatDate(appointment.appointmentDate)} | ${appointment.timeSlot ?? ""}",
                    ),

                    const SizedBox(height: 12),

                    header("Patient Problem"),
                    subHeader("${appointment.patientNotes}"),

                    const SizedBox(height: 16),

                    /// Reschedule Button
                    customOutlineButton(text: "Reschedule", onPressed: () {}),

                    const SizedBox(height: 12),

                    /// Cancel Button
                    Obx(
                      () => elevatedButton(
                        text: "Cancel Appointment",
                        onPressed: () {
                          ctr.cancelAppointment(appointment.id ?? '');
                        },
                        isLoading: ctr.isLoading.value,
                        background: AppColors.error,
                        textColor: AppColors.white,
                      ),
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
