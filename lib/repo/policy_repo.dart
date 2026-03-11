import 'package:eye_hospital/data/network/network_api_service.dart';
import 'package:eye_hospital/model/response/policy/about_res.dart';
import 'package:eye_hospital/model/response/policy/policy_res_model.dart';
import 'package:eye_hospital/res/app_urls.dart';

class PolicyRepo {
  final _api = NetworkApiService();

  Future<PolicyResModel> termPolicy() async {
    try {
      final res = await _api.getApi(AppUrls.termsandcondition);
      return PolicyResModel.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  Future<PolicyResModel> privacyPolicy() async {
    try {
      final res = await _api.getApi(AppUrls.privacypolicy);
      return PolicyResModel.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  Future<AboutUsResModel> getAboutUs() async {
    try {
      final res = await _api.getApi(AppUrls.aboutUs);
      return AboutUsResModel.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }
}
