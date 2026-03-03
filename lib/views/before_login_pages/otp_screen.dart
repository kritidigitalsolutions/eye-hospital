import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_dimensions.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/custom_textfields.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/view_model/before_login_controller/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});
  final data = Get.arguments;
  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    print(data);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Verify Your Code",
                  style: text24(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  "Enter the 6-digit code we just\nsent to your number",
                  textAlign: TextAlign.center,
                  style: text14(),
                ),

                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      6,
                      (index) => OtpTextField(
                        index: index,
                        controller: controller.otpControllers[index],
                        focusNode: controller.focusNodes[index],
                        onChanged: (value) =>
                            controller.onOtpChanged(value, index),
                        onBackspace: controller.handleBackspace, // ← naya
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CustomButton(
                      title: "Continue",
                      isLoading: controller.isLoading.value,
                      onPressed: () {
                        controller.submitOtp(data);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
