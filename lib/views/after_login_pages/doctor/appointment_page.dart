import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_dimensions.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/custom_textfields.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/view_model/after_login_controller/doctor_controller/doctor_controlles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentPage extends StatelessWidget {
  AppointmentPage({super.key});

  final controller = Get.put(AppointmentController());

  final data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(data["image"]),
              ),
              const SizedBox(height: 8),
              Text(data["name"], style: text16(fontWeight: FontWeight.bold)),

              const SizedBox(height: 12),

              /// Appointment Type
              //_chipButton("Physical Appointment", 0),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.primary,

                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary),
                ),
                child: Center(
                  child: Text(
                    "Physical Appointment",
                    style: text14(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey.shade700,
                    ),
                  ),
                ),
              ),

              // Obx(
              //   () => Row(
              //     children: [
              //       _chipButton("Physical Appointment", 0),
              //       const SizedBox(width: 8),
              //       _chipButton("Video Consultation", 1),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 16),

              /// Select Date
              _sectionTitle("Select Date"),

              Obx(
                () => EasyDateTimeLine(
                  initialDate: controller.selectedDates.value,
                  onDateChange: (date) {
                    controller.selectedDates.value = date;
                  },

                  activeColor: AppColors.primary,

                  headerProps: const EasyHeaderProps(
                    monthPickerType: MonthPickerType.switcher,
                    //  dateFormatter: DateFormatter.fullDateDMY,
                  ),

                  dayProps: EasyDayProps(
                    height: 60,
                    width: 60,

                    dayStructure: DayStructure.dayStrDayNum,

                    activeDayStyle: DayStyle(
                      dayNumStyle: text16(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      dayStrStyle: text16(color: AppColors.textPrimary),
                    ),

                    inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radius15,
                        ),
                      ),
                      dayNumStyle: text14(color: AppColors.black),
                      dayStrStyle: text14(color: AppColors.grey),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// Select Time
              _sectionTitle("Select Time"),
              Obx(
                () => Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.times.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2.6,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    itemBuilder: (context, index) {
                      return _timeItem(index);
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// Select type
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.radius15),
                  border: Border.all(color: AppColors.grey),
                ),
                child: Column(
                  children: [
                    _sectionTitle("Select type"),
                    SizedBox(height: 10),
                    Obx(
                      () => Row(
                        children: [
                          _selectTypeButton("General"),
                          const SizedBox(width: 8),
                          _selectTypeButton("Private"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// Select your consultation
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.radius15),
                  border: Border.all(color: AppColors.grey),
                ),
                child: Column(
                  children: [
                    _sectionTitle("Select your consultation"),
                    Obx(
                      () => Column(
                        children: List.generate(
                          controller.consultationList.length,
                          (index) {
                            return _consultationItem(index);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),

              _sectionTitle("What's Problem"),

              SizedBox(height: 10),
              CustomTextFieldWithBorder(
                maxLine: 3,
                controller: controller.patientIssue,
                hintText: "Enter your problem",
              ),

              const SizedBox(height: 20),

              /// Book Button
              Obx(
                () => CustomButton(
                  title: "Book Your Appointment",
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    final id = data['id'];
                    final isNew = data["isNew"];
                    controller.getAppointment(id, isNew);
                  },
                  borderRadius: AppDimensions.radiusExtraLarge,
                ),
              ),

              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
    );
  }

  // Widget _chipButton(String text, int index) {
  //   return Expanded(
  //     child: GestureDetector(
  //       onTap: () => controller.selectedAppointmentType.value = index,
  //       child: Container(
  //         padding: const EdgeInsets.symmetric(vertical: 10),
  //         decoration: BoxDecoration(
  //           color: controller.selectedAppointmentType.value == index
  //               ? AppColors.primary
  //               : AppColors.white,
  //           borderRadius: BorderRadius.circular(20),
  //           border: Border.all(color: AppColors.primary),
  //         ),
  //         child: Center(
  //           child: Text(
  //             text,
  //             style: text14(
  //               fontWeight: FontWeight.w500,
  //               color: controller.selectedAppointmentType.value == index
  //                   ? AppColors.black
  //                   : AppColors.grey.shade700,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _timeItem(int index) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.selectedTime.value = index;
          controller.selectedTimeSlot.value = controller.times[index];
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: controller.selectedTime.value == index
                ? AppColors.textSecondary
                : AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            controller.times[index],
            style: text14(
              fontWeight: FontWeight.bold,
              color: controller.selectedTime.value == index
                  ? AppColors.white
                  : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectTypeButton(String text) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectedType.value = text,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: controller.selectedType.value == text
                ? AppColors.primary
                : AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary),
          ),
          child: Center(
            child: Text(text, style: text14(fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget _consultationItem(int index) {
    final text = controller.consultationList[index];
    return GestureDetector(
      onTap: () => controller.selectedConsultation.value = text,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: controller.selectedConsultation.value == text
              ? AppColors.primary
              : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary),
        ),
        child: Center(
          child: Text(text, style: text14(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
