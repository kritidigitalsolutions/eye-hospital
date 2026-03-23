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

  // cart items

  Future<void> addCart(String id, String count) async {
    try {
      final token = HiveService.getToken();
      _api.setToken(token ?? '');
      await _api.postApi(AppUrls.addCart, {"productId": id, "quantity": count});
      // return ProductResModelDart.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCart(String id, String count) async {
    try {
      final token = HiveService.getToken();
      _api.setToken(token ?? '');
      await _api.postApi(AppUrls.updateCart, {
        "productId": id,
        "quantity": count,
      });
      // return ProductResModelDart.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeCart(String id) async {
    try {
      final token = HiveService.getToken();
      _api.setToken(token ?? '');
      await _api.deleteApi(AppUrls.updateCart, {"productId": id});
      // return ProductResModelDart.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  /// producrt review

  Future<dynamic> submitProductReview(
    String productId,
    Map<String, dynamic> body,
  ) async {
    try {
      final token = HiveService.getToken();
      _api.setToken(token ?? '');

      final url = "${AppUrls.product}/$productId/review";
      final res = await _api.postApi(url, body);

      return res;
    } catch (e) {
      print("Submit Review Repo Error: $e");
      rethrow;
    }
  }

  // top product

  Future<ProductResModelDart> topProduct() async {
    try {
      final token = HiveService.getToken();
      _api.setToken(token ?? '');
      final res = await _api.getApi(AppUrls.topProduct);
      return ProductResModelDart.fromJson(res);
    } catch (e) {
      print("Submit Review Repo Error: $e");
      rethrow;
    }
  }
}
