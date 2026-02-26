import 'package:eye_hospital/data/api_response.dart';
import 'package:eye_hospital/model/response/auth_response_model/auth_response_model.dart';
import 'package:eye_hospital/repo/auth_repo.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/custom_snakebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  var currentIndex = 0.obs;

  final List<Map<String, String>> onboardingData = [
    {"image": AppImages.on1, "title": "Book Appointments"},
    {"image": AppImages.on2, "title": "Access prescriptions"},
    {"image": AppImages.on3, "title": "Buy spectacles online"},
  ];

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void nextPage() {
    if (currentIndex.value < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.offNamed(AppRoutes.loginPage);
    }
  }

  void skip() {
    Get.offNamed(AppRoutes.loginPage);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  // ------------------------------------------------------
  // Api
  //--------------------------------------

  final _repo = AuthRepo();

  var data = ApiResponse<List<OnBoardingData>>.loading().obs;

  Future<void> getOnBoarding() async {
    data.value = ApiResponse.loading();

    try {
      final res = await _repo.getOnBoarding();
      data.value = ApiResponse.completed(res.data);
    } catch (e) {
      data.value = ApiResponse.error(e.toString());

      CustomSnakebar.error(
        "Error",
        "Something went wrong. Please try again later",
      );
    }
  }
}
