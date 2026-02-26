import 'package:dio/dio.dart';
import 'package:eye_hospital/data/network/network_api_service.dart';
import 'package:eye_hospital/model/request/auth_request_model/auth_request_model.dart';
import 'package:eye_hospital/res/app_urls.dart';

class ProfileRepo {
  final _api = NetworkApiService();

  Future<void> editProfile(UserDetailsReqModel model) async {
    try {
      FormData formData = FormData.fromMap({
        "name": model.name,
        "dob": model.dob,
        "gender": model.gender,

        // image only if not null or empty
        if (model.image != null && model.image!.isNotEmpty)
          "image": await MultipartFile.fromFile(
            model.image!,
            filename: model.image!.split('/').last,
          ),
      });

      final res = await _api.postApi(AppUrls.onBoarding, formData);
    } catch (e) {
      rethrow;
    }
  }
}
