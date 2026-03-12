import 'dart:async';

import 'package:get/get.dart';
import '../../../data/api_response.dart';
import '../../../model/response/cart_res/cart_res_model.dart';
import '../../../repo/cart_repo.dart';
import '../../../utils/custom_snakebar.dart';

class CartController extends GetxController {
  final _repo = CartRepo();
  Timer? _debounce;

  var cartData = ApiResponse<CartResModel>.completed(null).obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCart();
  }

  void changeQuantityLocally({required int index, required int newQuantity}) {
    final items = cartData.value.data?.items;

    if (items == null) return;

    cartData.refresh(); // instant UI update

    // debounce API call
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () {
      final item = items[index];

      updateQuantity(
        productId: item.id ?? "",
        quantity: newQuantity,
        selectedColor: item.selectedColor ?? "",
      );
    });
  }

  bool isProductInCart(String productId) {
    final cartItems = cartData.value.data?.items ?? [];

    return cartItems.any((item) => item.product?.id == productId);
  }

  // ----------------------------------
  // ✅ Get Cart
  // ----------------------------------
  Future<void> getCart() async {
    cartData.value = ApiResponse.loading();
    try {
      final res = await _repo.getCart();
      cartData.value = ApiResponse.completed(res);
    } catch (e) {
      cartData.value = ApiResponse.error(e.toString());
      CustomSnakebar.error("Error", "Failed to fetch cart data.");
    }
  }

  // ----------------------------------
  // ✅ Add To Cart
  // ----------------------------------
  Future<void> addToCart({
    required String productId,
    required int quantity,
    required String selectedColor,
  }) async {
    isLoading.value = true;
    try {
      await _repo.addToCart(
        productId: productId,
        quantity: quantity,
        selectedColor: selectedColor,
      );

      await getCart(); // 🔥 refresh cart

      CustomSnakebar.success("Added to Cart", "Product added successfully.");
    } catch (e) {
      CustomSnakebar.error("Error", "Unable to add product.");
    } finally {
      isLoading.value = false;
    }
  }

  // ----------------------------------
  // ✅ Total Items Count
  // ----------------------------------
  int get totalItems {
    return cartData.value.data?.items.length ?? 0;
  }

  // ----------------------------------
  // ✅ Total Price
  // ----------------------------------
  int get totalPrice {
    final items = cartData.value.data?.items ?? [];

    return items.fold(0, (sum, item) {
      final price = item.product?.discountedPrice ?? item.product?.price ?? 0;

      final quantity = item.quantity ?? 0;

      return sum + (price * quantity);
    });
  }

  // ----------------------------------
  // ✅ Total Price
  // ----------------------------------
  Future<void> updateQuantity({
    required String productId,
    required int quantity,
    required String selectedColor,
  }) async {
    try {
      await _repo.updateCart(
        productId: productId,
        quantity: quantity,
        selectedColor: selectedColor,
      );

      // Refresh cart after update
      // await getCart();
    } catch (e) {
      print("Update quantity error: $e");
    }
  }

  // ----------------------------------
  // ✅ Total Price
  // ----------------------------------
  Future<void> removeCart({required String productId}) async {
    try {
      await _repo.removeCart(productId: productId);
      getCart();
    } catch (e) {
      print("remove cart error: $e");
    }
  }
}
