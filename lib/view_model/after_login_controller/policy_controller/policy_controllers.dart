import 'package:eye_hospital/repo/policy_repo.dart';
import 'package:eye_hospital/utils/custom_snakebar.dart';
import 'package:get/get.dart';

class PolicyControllers extends GetxController {
  final PolicyRepo _repo = PolicyRepo();

  var isLoading = false.obs;

  /// Add to cart
  Future<void> fetchPolicy() async {
    isLoading.value = true;
    try {
      await _repo.fetchPolicy();
    } catch (e) {
      CustomSnakebar.error("Error", "Failed to load policy");
    } finally {
      isLoading.value = false;
    }
  }
}
