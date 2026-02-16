import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_dimensions.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/custom_textfields.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/view_model/before_login_controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            ),
            child: Obx(
              () => SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Basic\nDetails",
                        textAlign: TextAlign.center,
                        style: text24(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 24),

                      /// Full Name
                      CustomTextFieldWithBorder(
                        controller: controller.nameController,
                        hintText: "Full Name",
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your name";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      /// DOB
                      CustomTextFieldWithBorder(
                        controller: controller.dobController,
                        hintText: "Date of birth",
                        readOnly: true,
                        onTap: () => controller.selectDate(context),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Please select your date of birth";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      /// Gender Box
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusMedium,
                          ),
                          border: Border.all(color: AppColors.grey),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Gender"),

                            const SizedBox(height: 8),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                genderButton("Male"),
                                SizedBox(width: 6),
                                genderButton("Female"),
                                SizedBox(width: 6),
                                genderButton("Other"),
                              ],
                            ),

                            if (controller.genderError.value.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  controller.genderError.value,
                                  style: const TextStyle(
                                    color: AppColors.error,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// Button
                      CustomButton(
                        title: "Get Started",
                        onPressed: () {
                          print("validation---------------");
                          controller.validateForm();
                          print("validation-----------fdgfdgf----");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// reusable textfield

  /// gender button
  Widget genderButton(String text) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectGender(text),
        child: Container(
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: controller.selectedGender.value == text
                ? AppColors.primary
                : AppColors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
            border: Border.all(
              color: controller.selectedGender.value == text
                  ? AppColors.primary
                  : AppColors.grey,
            ),
          ),
          child: Text(text, style: text14(color: AppColors.textPrimary)),
        ),
      ),
    );
  }
}
