import '../data/network/network_api_service.dart';
import '../res/app_urls.dart';
import '../utils/hive_service/hive_service.dart';

class TrackOrderRepo {
  final _api = NetworkApiService();

  Future<dynamic> trackOrder(String orderId) async {
    final token = HiveService.getToken();
    _api.setToken(token ?? '');

    final response = await _api.getApi(
      AppUrls.trackOrder(orderId),
    );
    print(response);

    return response;
  }
}
