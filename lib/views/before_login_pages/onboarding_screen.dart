import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/view_model/before_login_controller/onboading_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: controller.skip,
                  child: const Text("Skip"),
                ),
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.onboardingData.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        controller.onboardingData[index]["image"]!,
                        height: 300,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        controller.onboardingData[index]["title"]!,
                        style: text20(),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Dots Indicator
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.onboardingData.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: controller.currentIndex.value == index ? 12 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: controller.currentIndex.value == index
                          ? AppColors.primary
                          : AppColors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Next Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: Obx(
                  () => CustomButton(
                    title:
                        controller.currentIndex.value ==
                            controller.onboardingData.length - 1
                        ? "Get Started"
                        : "Next",
                    onPressed: () {
                      controller.nextPage();
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
