import 'package:dio/dio.dart';
import 'package:eye_hospital/data/network/network_api_service.dart';
import 'package:eye_hospital/model/request/auth_request_model/auth_request_model.dart';
import 'package:eye_hospital/model/response/auth_response_model/auth_response_model.dart';
import 'package:eye_hospital/res/app_urls.dart';

class AuthRepo {
  final _api = NetworkApiService();

  // onboarding repo

  Future<OnBoardingResponseModel> getOnBoarding() async {
    try {
      final res = await _api.getApi(AppUrls.onBoarding);
      return OnBoardingResponseModel.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  // send otp

  Future<void> sendOtp(String phone) async {
    try {
      await _api.postApi(AppUrls.sentOtp, {"phone": phone});
    } catch (e) {
      rethrow;
    }
  }

  // send otp

  Future<Map<String, dynamic>> verfiyOtp(String phone, String otp) async {
    try {
      final res = await _api.postApi(AppUrls.otpVerify, {
        "otp": otp,
        "phone": phone,
      });
      return res;
    } catch (e) {
      rethrow;
    }
  }

  // send otp

  Future<UserDetailsResModel> registerUser(UserDetailsReqModel model) async {
    try {
      print("📤 REGISTER API CALLED");
      print("REGISTER DATA => ${model.toJson()}");

      final dio = Dio();

      final formData = FormData.fromMap({
        "name": model.name,
        "dob": model.dob,
        "gender": model.gender,
        "phone": model.phone,
        if (model.image != null && model.image!.isNotEmpty)
          "profileImage": await MultipartFile.fromFile(
            model.image!,
            filename: model.image!.split('/').last,
          ),
      });

      final response = await dio.post(AppUrls.register, data: formData);

      print("✅ REGISTER RESPONSE => ${response.data}");

      return UserDetailsResModel.fromJson(response.data);
    } catch (e) {
      print("❌ REGISTER ERROR => $e");
      rethrow;
    }
  }
}
