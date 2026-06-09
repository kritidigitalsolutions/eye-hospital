import 'package:eye_hospital/data/api_response.dart';
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
        child: Obx(() {
          switch (controller.data.value.status) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());

            case Status.error:
              return const Center(child: Text("Failed to load onboarding"));

            case Status.completed:
              final list = controller.data.value.data ?? [];

              return Column(
                children: [
                  // Skip Button
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextButton(
                        onPressed: controller.skip,
                        child: Text("Skip", style: text14()),
                      ),
                    ),
                  ),

                  // PageView
                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,
                      onPageChanged: controller.onPageChanged,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              list[index].image,
                              height: 300,
                              errorBuilder: (_, _, _) =>
                                  const Icon(Icons.image_not_supported),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              list[index].title,
                              style: text20(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  // Dots Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      list.length,
                      (index) => Obx(
                        () => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: controller.currentIndex.value == index
                              ? 12
                              : 8,
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
                              controller.currentIndex.value == list.length - 1
                              ? "Get Started"
                              : "Next",
                          onPressed: () {
                            controller.nextPage(list.length);
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              );
          }
        }),
      ),
    );
  }
}
