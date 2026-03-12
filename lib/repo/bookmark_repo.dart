import '../data/network/network_api_service.dart';
import '../model/response/bookmark_res/bookmark_res_model.dart';
import '../res/app_urls.dart';
import '../utils/hive_service/hive_service.dart';

class BookmarkRepo {
  final _api = NetworkApiService();

  // ---------------- ADD BOOKMARK ----------------

  Future<BookmarkResModel> addBookmark(String productId) async {
    final token = HiveService.getToken();
    _api.setToken(token ?? '');

    final body = {"productId": productId};

    final res = await _api.postApi(AppUrls.addbookmark, body);

    return BookmarkResModel.fromJson(res);
  }

  // ---------------- GET BOOKMARKS ----------------

  Future<BookmarkResModel> getBookmarks() async {
    final token = HiveService.getToken();
    _api.setToken(token ?? '');

    final res = await _api.getApi(AppUrls.getBookmark);

    return BookmarkResModel.fromJson(res);
  }

  // ---------------- REMOVE BOOKMARK ----------------

  Future<BookmarkResModel> removeBookmark(String productId) async {
    final token = HiveService.getToken();
    _api.setToken(token ?? '');

    final res = await _api.deleteApi(
      "${AppUrls.removeBookmark}/$productId",
      {}, // empty body
    );

    return BookmarkResModel.fromJson(res);
  }
}
