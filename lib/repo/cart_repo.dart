import '../data/network/network_api_service.dart';
import '../res/app_urls.dart';
import '../utils/hive_service/hive_service.dart';
import '../model/response/cart_res/cart_res_model.dart';

class CartRepo {
  final _api = NetworkApiService();

  // -------------------------------
  // ✅ Add To Cart
  // -------------------------------
  Future<dynamic> addToCart({
    required String productId,
    required int quantity,
    required String selectedColor,
  }) async {
    try {
      final token = HiveService.getToken();
      _api.setToken(token ?? '');

      final body = {
        "productId": productId,
        "quantity": quantity,
        "selectedColor": selectedColor,
      };

      final res = await _api.postApi(
        AppUrls.addCart,
        body,
      );

      return res;
    } catch (e) {
      rethrow;
    }
  }

  // -------------------------------
  // ✅ Get Cart
  // -------------------------------
  Future<CartResModel> getCart() async {
    try {
      final token = HiveService.getToken();
      _api.setToken(token ?? '');

      final res = await _api.getApi(AppUrls.getCart);
      print("FULL API RESPONSE: $res"); // 🔥 ADD THIS

      return CartResModel.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }
  // -------------------------------
  // ✅ update cart
  // -------------------------------

  Future<void> updateCart({
    required String productId,
    required int quantity,
    required String selectedColor,
  }) async {
    try {
      final token = HiveService.getToken();
      _api.setToken(token ?? '');

      final body = {
        "productId": productId,
        "quantity": quantity,
        "selectedColor": selectedColor,
      };

      final res = await _api.pacthApi(
        AppUrls.updateCart,
        body,
      );

      print("Update Cart Response: $res");
    } catch (e) {
      rethrow;
    }
  }

}
