import 'package:get/get.dart';

import '../../../model/response/track_order_res/track_order_res.dart';
import '../../../repo/track_order_repo.dart';

class OrderController extends GetxController {
  final TrackOrderRepo _repo = TrackOrderRepo();

  RxBool loading = false.obs;
  Rx<TrackOrderModel?> orderData = Rx<TrackOrderModel?>(null);

  Future<void> getTrackOrder(String orderId) async {
    try {
      loading.value = true;

      final response = await _repo.trackOrder(orderId);

      orderData.value = TrackOrderModel.fromJson(response);
    } catch (e) {
      print("Track Order Error: $e");
    } finally {
      loading.value = false;
    }
  }
}
