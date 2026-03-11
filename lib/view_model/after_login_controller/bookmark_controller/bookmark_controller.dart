import 'package:get/get.dart';
import '../../../repo/bookmark_repo.dart';
import '../../../model/response/bookmark_res/bookmark_res_model.dart';

class BookmarkController extends GetxController {
  final BookmarkRepo _repo = BookmarkRepo();

  RxBool isLoading = false.obs;

  RxList<BookmarkModel> bookmarks = <BookmarkModel>[].obs;

  // -------- ADD BOOKMARK --------

  Future<void> addBookmark(String productId) async {
    try {
      isLoading.value = true;

      final res = await _repo.addBookmark(productId);

      if (res.success == true) {
        Get.snackbar("Success", res.message ?? "Added to favourites");

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
    return bookmarks.any((item) => item.product.id == productId);
  }

  Future<void> getBookmarks() async {
    try {
      isLoading.value = true;

      final data = await _repo.getBookmarks();

      bookmarks.value = data;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
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
      await _repo.removeBookmark(productId);

      getBookmarks();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
