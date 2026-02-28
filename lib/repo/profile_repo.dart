import 'package:dio/dio.dart';
import 'package:eye_hospital/model/request/auth_request_model/auth_request_model.dart';
import 'package:eye_hospital/res/app_urls.dart';
import 'package:eye_hospital/utils/hive_service/hive_service.dart';
import 'package:eye_hospital/utils/hive_service/userdetail.dart';

class ProfileRepo {
  Future<UserDetails> editProfile(UserDetailsReqModel model) async {
    try {
      final dio = Dio();
      final token = HiveService.getToken();

      dio.options.headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "multipart/form-data",
      };

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

      final response = await dio.patch(AppUrls.editProfile, data: formData);

      print("✅ RESPONSE => ${response.data}");

      final userJson = response.data["user"];

      // ✅ get old user (for token & image)
      final oldUser = HiveService.getUser();

      final user = UserDetails(
        name: userJson["name"] ?? "",
        dob: userJson["dob"] ?? "",
        gender: userJson["gender"] ?? "",
        phone: userJson["phone"],
        image: model.image ?? oldUser?.image,
        token: oldUser?.token ?? "",
      );

      // ✅ save updated user in Hive
      await HiveService.saveUser(user);

      return user;
    } catch (e) {
      print("❌ ERROR => $e");
      rethrow;
    }
  }
}
