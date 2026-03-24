import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_dimensions.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/custom_textfields.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/view_model/before_login_controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

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
            child: Form(
              key: controller.formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Enter Mobile\nNumber",
                      textAlign: TextAlign.center,
                      style: text24(fontWeight: FontWeight.w600),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusSmall,
                            ),
                          ),
                          child: Text(
                            "+91",
                            style: text16(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),

                        Expanded(
                          child: CustomTextField(
                            controller: controller.phoneController,
                            hintText: "Enter mobile number",
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            isNumberOnly: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter mobile number";
                              } else if (value.length != 10) {
                                return "Enter valid 10 digit number";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Text("Or", style: text20(fontWeight: FontWeight.w600)),
                    // const SizedBox(height: 10),
                    Text(
                      "Login / Signup",
                      style: text18(fontWeight: FontWeight.w600),
                    ),
                    //  const SizedBox(height: 16),

                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 45,
                    //   child: ElevatedButton.icon(
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: AppColors.primary,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(
                    //           AppDimensions.radiusSmall,
                    //         ),
                    //       ),
                    //     ),
                    //     onPressed: () {},
                    //     icon: Image.asset(
                    //       AppImages.google,
                    //       width: 24,
                    //       height: 24,
                    //     ),
                    //     label: Text(
                    //       "Login with Google",
                    //       style: text14(
                    //         fontWeight: FontWeight.w600,
                    //         color: AppColors.buttonText,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 20),

                    Obx(
                      () => CustomButton(
                        title: "Continue",
                        isLoading: controller.isLoading.value,
                        onPressed: controller.submit,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
