import '../data/network/network_api_service.dart';
import '../res/app_urls.dart';
import '../utils/hive_service/hive_service.dart';

class SupportRepo {

  final _api = NetworkApiService();

  Future<dynamic> sendSupportQuery(String query) async {
    try {

      final token = HiveService.getToken();
      _api.setToken(token ?? '');

      final body = {
        "query": query
      };

      final res = await _api.postApi(
        AppUrls.support,
        body,
      );

      return res;

    } catch (e) {
      rethrow;
    }
  }
}
