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

  Future<void> verfiyOtp(String phone, String otp) async {
    try {
      await _api.postApi(AppUrls.otpVerify, {"otp": otp, "phone": phone});
    } catch (e) {
      rethrow;
    }
  }

  // send otp

  Future<UserDetailsResModel> registerUser(UserDetailsReqModel model) async {
    try {
      final dio = Dio();

      // create FormData separately
      final formData = FormData.fromMap({
        "name": model.name,
        "dob": model.dob,
        "gender": model.gender,

        // optional image
        if (model.image != null && model.image!.isNotEmpty)
          "image": await MultipartFile.fromFile(
            model.image!,
            filename: model.image!.split('/').last,
          ),
      });

      final response = await dio.post(
        AppUrls.register,
        data: formData,
        options: Options(
          headers: {
            "Accept": "application/json",
            // do NOT set Content-Type manually for FormData
          },
        ),
      );

      return UserDetailsResModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
