import 'package:eye_hospital/data/api_response.dart';
import 'package:get/get.dart';
import '../../../repo/bookmark_repo.dart';
import '../../../model/response/bookmark_res/bookmark_res_model.dart';

class BookmarkController extends GetxController {
  final BookmarkRepo _repo = BookmarkRepo();

  RxBool isLoading = false.obs;

  var bookmarks = ApiResponse<BookmarkResModel>.loading().obs;

  // -------- ADD BOOKMARK --------

  Future<void> addBookmark(String productId) async {
    try {
      isLoading.value = true;

      final res = await _repo.addBookmark(productId);

      if (res.success == true) {
        getBookmarks(); // refresh liked list
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // -------- GET BOOKMARKS --------

  bool isProductBookmark(String productId) {
    final bookmark = bookmarks.value.data?.bookmarks ?? [];
    return bookmark.any((item) => item.product?.id == productId);
  }

  Future<void> getBookmarks() async {
    try {
      bookmarks.value = ApiResponse.loading();

      final data = await _repo.getBookmarks();

      bookmarks.value = ApiResponse.completed(data);
    } catch (e) {
      bookmarks.value = ApiResponse.error(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getBookmarks();
  }

  // -------- REMOVE BOOKMARK --------

  Future<void> removeBookmark(String productId) async {
    try {
      final list = bookmarks.value.data?.bookmarks ?? [];

      /// remove locally first (smooth UI)
      list.removeWhere((item) => item.product?.id == productId);

      bookmarks.refresh();

      /// call API
      await _repo.removeBookmark(productId);
    } catch (e) {
      Get.snackbar("Error", "Failed to remove bookmark");
    }
  }
}
