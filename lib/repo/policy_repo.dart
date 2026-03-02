import 'package:eye_hospital/data/network/network_api_service.dart';
import 'package:eye_hospital/res/app_urls.dart';

class PolicyRepo {
  final _api = NetworkApiService();

  Future<void> fetchPolicy() async {
    try {
      final res = await _api.getApi(AppUrls.policy);
      // return .fromJson(res);
    } catch (e) {
      rethrow;
    }
  }
}
