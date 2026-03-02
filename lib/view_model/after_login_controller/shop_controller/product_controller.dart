import 'package:eye_hospital/data/api_response.dart';
import 'package:eye_hospital/model/response/product_res/product_res_model.dart';
import 'package:eye_hospital/repo/product_repo.dart';
import 'package:eye_hospital/utils/custom_snakebar.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxInt selectedCategory = 0.obs;

  final categories = ["Spectacles", "Lenses", "Frames"];

  final _repo = ProductRepo();

  var productList = ApiResponse<ProductResModelDart>.loading().obs;

  @override
  void onInit() {
    fetchProduct();
    super.onInit();
  }

  Future<void> fetchProduct() async {
    productList.value = ApiResponse.loading();
    try {
      final res = await _repo.getProduct();
      productList.value = ApiResponse.completed(res);
    } catch (e) {
      productList.value = ApiResponse.error(e.toString());
      CustomSnakebar.error("Error", "Failed to load products");
    }
  }

  /// ✅ Filter products by selected category
  List<Product> get filteredProducts {
    if (productList.value.data == null) return [];

    final allProducts = productList.value.data!.products;

    if (selectedCategory.value == 0) {
      return allProducts.where((p) => p.category == "spectacles").toList();
    } else if (selectedCategory.value == 1) {
      return allProducts.where((p) => p.category == "lenses").toList();
    } else {
      return allProducts.where((p) => p.category == "frames").toList();
    }
  }
}

//----------------------------------------------------------
// product cart
//------------------------------------------------------------------

class ProductCartController extends GetxController {
  final ProductRepo _repo = ProductRepo();

  var isLoading = false.obs;

  /// Add to cart
  Future<void> addToCart(String productId, String quantity) async {
    isLoading.value = true;
    try {
      await _repo.addCart(productId, quantity);

      CustomSnakebar.success(
        "Added to Cart",
        "Product added to cart successfully",
      );
    } catch (e) {
      CustomSnakebar.error("Error", "Failed to add product to cart");
    } finally {
      isLoading.value = false;
    }
  }

  /// Update cart quantity
  Future<void> updateCartQty(String productId, String quantity) async {
    isLoading.value = true;
    try {
      await _repo.updateCart(productId, quantity);

      CustomSnakebar.success("Updated", "Cart updated successfully");
    } catch (e) {
      CustomSnakebar.error("Error", "Failed to update cart");
    } finally {
      isLoading.value = false;
    }
  }

  /// Remove from cart
  Future<void> removeFromCart(String productId) async {
    isLoading.value = true;
    try {
      await _repo.removeCart(productId);

      CustomSnakebar.success("Removed", "Product removed from cart");
    } catch (e) {
      CustomSnakebar.error("Error", "Failed to remove product from cart");
    } finally {
      isLoading.value = false;
    }
  }
}
