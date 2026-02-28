import 'package:eye_hospital/data/network/network_api_service.dart';
import 'package:eye_hospital/model/response/product_res/product_res_model.dart';
import 'package:eye_hospital/res/app_urls.dart';
import 'package:eye_hospital/utils/hive_service/hive_service.dart';

class ProductRepo {
  final _api = NetworkApiService();

  // search doctor

  Future<ProductResModelDart> getProduct() async {
    try {
      final token = HiveService.getToken();
      _api.setToken(token ?? '');
      final res = await _api.getApi(AppUrls.product);
      return ProductResModelDart.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }
}
