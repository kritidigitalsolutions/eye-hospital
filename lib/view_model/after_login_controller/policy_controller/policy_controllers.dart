import 'package:eye_hospital/data/api_response.dart';
import 'package:eye_hospital/model/response/policy/about_res.dart';
import 'package:eye_hospital/model/response/policy/policy_res_model.dart';
import 'package:eye_hospital/repo/policy_repo.dart';
import 'package:eye_hospital/utils/custom_snakebar.dart';
import 'package:get/get.dart';

class PolicyControllers extends GetxController {
  final PolicyRepo _repo = PolicyRepo();

  var policy = ApiResponse<PolicyResModel>.loading().obs;

  /// ---------------------------- term ------------------------------
  ///
  Future<void> fetchTermPolicy() async {
    policy.value = ApiResponse.loading();
    try {
      final res = await _repo.termPolicy();

      policy.value = ApiResponse.completed(res);
    } catch (e) {
      policy.value = ApiResponse.error("Failed to load policy");
      CustomSnakebar.error("Error", "Failed to load policy");
    }
  }

  //------------------------- privacy policy ----------------------------

  Future<void> fetchPrivacyPolicy() async {
    policy.value = ApiResponse.loading();
    try {
      final res = await _repo.privacyPolicy();

      policy.value = ApiResponse.completed(res);
    } catch (e) {
      policy.value = ApiResponse.error(
        "Failed to load term and condition policy",
      );
      CustomSnakebar.error("Error", "Failed to load policy");
    }
  }

  //------------------------ about us -----------------------------------
  var aboutUs = ApiResponse<AboutUsResModel>.loading().obs;

  Future<void> fetchPolicy() async {
    aboutUs.value = ApiResponse.loading();
    try {
      final res = await _repo.getAboutUs();

      aboutUs.value = ApiResponse.completed(res);
    } catch (e) {
      aboutUs.value = ApiResponse.error(
        "Failed to load term and condition policy",
      );
      CustomSnakebar.error("Error", "Failed to load policy");
    }
  }
}
