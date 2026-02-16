import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindDoctorController extends GetxController {
  final searchDoctorCtr = TextEditingController();
}

class AppointmentController extends GetxController {
  Rx<DateTime> selectedDates = DateTime.now().obs;

  RxInt selectedTime = 0.obs;
  RxInt selectedType = 0.obs;
  RxInt selectedConsultation = 0.obs;

  RxInt selectedAppointmentType = 0.obs;

  RxList<String> times = List.generate(12, (index) => "8:30 pm").obs;

  RxList<String> consultationList = <String>[
    "First Consultation",
    "Follow Up Consultation",
    "Fast Track consultation ( First )",
    "Fast Track consultation ( Follow Up )",
  ].obs;
}
