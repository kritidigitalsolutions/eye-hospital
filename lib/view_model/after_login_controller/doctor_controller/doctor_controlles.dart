import 'package:eye_hospital/data/api_response.dart';
import 'package:eye_hospital/model/request/doctor_req/doctor_req_model.dart';
import 'package:eye_hospital/model/response/doctor_res/appointment_res_model.dart';
import 'package:eye_hospital/model/response/doctor_res/doctor_list_res_model.dart';
import 'package:eye_hospital/repo/doctor_repo.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/custom_snakebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FindDoctorController extends GetxController {
  final searchDoctorCtr = TextEditingController();

  final _repo = DoctorRepo();

  var doctorList = ApiResponse<DoctorListResModel>.completed(null).obs;

  /// filtered list
  RxList<Doctor> filteredDoctors = <Doctor>[].obs;

  @override
  void onInit() {
    super.onInit();
    searchDoctor();

    // 🔥 listen to search text
    searchDoctorCtr.addListener(() {
      filterDoctors(searchDoctorCtr.text);
    });
  }

  Future<void> searchDoctor() async {
    doctorList.value = ApiResponse.loading();
    try {
      final res = await _repo.searchDoctor();
      doctorList.value = ApiResponse.completed(res);

      // initially show all doctors
      filteredDoctors.value = res.doctors;
    } catch (e) {
      doctorList.value = ApiResponse.error(e.toString());
      CustomSnakebar.error(
        "Error",
        "Something went wrong. Please try again later",
      );
    }
  }

  /// 🔍 filter logic
  void filterDoctors(String query) {
    final doctors = doctorList.value.data?.doctors ?? [];

    if (query.isEmpty) {
      filteredDoctors.value = doctors;
    } else {
      filteredDoctors.value = doctors.where((doctor) {
        final name = doctor.name?.toLowerCase() ?? "";
        final specialization = doctor.specialization?.toLowerCase() ?? "";

        return name.contains(query.toLowerCase()) ||
            specialization.contains(query.toLowerCase());
      }).toList();
    }
  }

  Future<void> refreshDoctors() async {
    await searchDoctor(); // your existing API method
  }
}

class AppointmentController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    generateTimeSlots();
  }

  Rx<DateTime> selectedDates = DateTime.now().obs;
  final patientIssue = TextEditingController();

  RxInt selectedTime = 0.obs;
  RxString selectedType = "General".obs;
  RxString selectedConsultation = "First Consultation".obs;

  RxInt selectedAppointmentType = 0.obs;

  RxString selectedTimeSlot = ''.obs;

  RxList<String> times = <String>[].obs;

  void generateTimeSlots() {
    List<String> slots = [];

    // 10:00 AM to 1:00 PM
    DateTime startMorning = DateTime(2026, 1, 1, 10, 0);
    DateTime endMorning = DateTime(2026, 1, 1, 13, 0);

    while (startMorning.isBefore(endMorning)) {
      slots.add(_formatTime(startMorning));
      startMorning = startMorning.add(const Duration(minutes: 30));
    }

    // 2:00 PM to 6:00 PM
    DateTime startEvening = DateTime(2026, 1, 1, 14, 0);
    DateTime endEvening = DateTime(2026, 1, 1, 18, 0);

    while (startEvening.isBefore(endEvening)) {
      slots.add(_formatTime(startEvening));
      startEvening = startEvening.add(const Duration(minutes: 30));
    }

    times.value = slots;
  }

  String _formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? "PM" : "AM";
    return "$hour:$minute $period";
  }

  RxList<String> consultationList = <String>[
    "First Consultation",
    "Follow Up Consultation",
    "Fast Track consultation ( First )",
    "Fast Track consultation ( Follow Up )",
  ].obs;

  // api----------------------------------------

  final _repo = DoctorRepo();
  var isLoading = false.obs;

  Future<void> getAppointment(String id, bool isNew) async {
    isLoading.value = true;
    if (id.isEmpty) {
      CustomSnakebar.error(
        "Invalid Doctor",
        "Doctor information is missing. Please try again.",
      );
      return;
    }
    try {
      final model = AppointmentRequestModel(
        doctorId: id,
        appointmentType: "Physical Appointment",
        consultationType: selectedConsultation.value,
        patientType: selectedType.value,
        appointmentDate: DateFormat("yyyy-MM-dd").format(selectedDates.value),
        timeSlot: selectedTimeSlot.value,
        patientNotes: patientIssue.text.trim(),
      );

      if (isNew) {
        await _repo.postAppointment(model);
        Get.offAllNamed(AppRoutes.myAppointment);
        CustomSnakebar.success(
          "Appointment Booked",
          "Your appointment has been successfully scheduled.",
        );
      } else {
        await _repo.rescheduleAppointment(id, model);
        Get.offAllNamed(AppRoutes.myAppointment);
        CustomSnakebar.success(
          "Appointment Booked",
          "Your appointment has been successfully rescheduled.",
        );
      }
    } catch (e) {
      CustomSnakebar.error(
        "Error",
        "Something went wrong. Please try again later",
      );
    } finally {
      isLoading.value = false;
    }
  }
}

// ------------------------------------------------------------
// get my appointment
//------------------------------------------------------------------

class MyAppOintmentController extends GetxController {
  final _repo = DoctorRepo();

  var myAppointment = ApiResponse<MyAppointmentResModelDart>.completed(
    null,
  ).obs;
  var selectedStatus = "all".obs;
  @override
  void onInit() {
    super.onInit();
    getAppointment();
  }

  Future<void> getAppointment() async {
    myAppointment.value = ApiResponse.loading();
    try {
      final res = await _repo.getAppointment();
      myAppointment.value = ApiResponse.completed(res);
    } catch (e) {
      myAppointment.value = ApiResponse.error(e.toString());
      CustomSnakebar.error(
        "Error",
        "Something went wrong. Please try again later",
      );
    }
  }

  /// 🔹 Filtered list
  List<Appointment> get filteredAppointments {
    final list = myAppointment.value.data?.appointments ?? [];

    if (selectedStatus.value == "all") return list;

    return list
        .where(
          (e) => e.status?.toLowerCase() == selectedStatus.value.toLowerCase(),
        )
        .toList();
  }

  /// 🔹 Count by status
  int countByStatus(String status) {
    final list = myAppointment.value.data?.appointments ?? [];
    return list
        .where((e) => e.status?.toLowerCase() == status.toLowerCase())
        .length;
  }

  int get totalCount => myAppointment.value.data?.appointments.length ?? 0;

  var isLoading = false.obs;

  Future<void> cancelAppointment(String id) async {
    isLoading.value = true;
    try {
      await _repo.cancelAppointment(id);
      getAppointment();
      Get.back();
      CustomSnakebar.success(
        "Appointment Cancelled",
        "Your appointment has been cancelled successfully.",
      );
    } catch (e) {
      CustomSnakebar.error(
        "Error",
        "Something went wrong. Please try again later",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
