import '../data/network/network_api_service.dart';
import '../model/response/about_res/about_res.dart';
import '../res/app_urls.dart';
import '../utils/hive_service/hive_service.dart';

class AboutRepo {
  final _api = NetworkApiService();

  Future<AboutResModel> getAboutUs() async {
    try {
      final token = HiveService.getToken();
      _api.setToken(token ?? '');

      final res = await _api.getApi(AppUrls.aboutUs);

      return AboutResModel.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }
}
