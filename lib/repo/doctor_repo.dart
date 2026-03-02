import 'package:eye_hospital/data/network/network_api_service.dart';
import 'package:eye_hospital/model/request/doctor_req/doctor_req_model.dart';
import 'package:eye_hospital/model/response/doctor_res/appointment_res_model.dart';
import 'package:eye_hospital/model/response/doctor_res/doctor_list_res_model.dart';
import 'package:eye_hospital/res/app_urls.dart';
import 'package:eye_hospital/utils/hive_service/hive_service.dart';

class DoctorRepo {
  final _api = NetworkApiService();

  // search doctor

  Future<DoctorListResModel> searchDoctor() async {
    try {
      final token = HiveService.getToken();
      _api.setToken(token ?? '');
      final res = await _api.getApi(AppUrls.searchDoctor);
      return DoctorListResModel.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  // appointment page

  Future<void> postAppointment(AppointmentRequestModel model) async {
    try {
      final token = HiveService.getToken();
      _api.setToken(token ?? '');
      await _api.postApi(AppUrls.appointmentBooked, model.toJson());
    } catch (e) {
      rethrow;
    }
  }

  // appointment page

  Future<MyAppointmentResModelDart> getAppointment() async {
    try {
      final token = HiveService.getToken();
      _api.setToken(token ?? '');
      final res = await _api.getApi(AppUrls.myAppointment);

      return MyAppointmentResModelDart.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  // appointment page

  Future<MyAppointmentResModelDart> cancelAppointment(String id) async {
    try {
      final token = HiveService.getToken();
      _api.setToken(token ?? '');

      final uri = "${AppUrls.appointments}/$id/cancel";
      final res = await _api.pacthApi(uri, {});

      return MyAppointmentResModelDart.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  Future<MyAppointmentResModelDart> rescheduleAppointment(
    String id,
    AppointmentRequestModel model,
  ) async {
    try {
      final token = HiveService.getToken();
      _api.setToken(token ?? '');

      final uri = "${AppUrls.appointments}/$id/reschedule";
      final res = await _api.postApi(uri, model.toJson());

      return MyAppointmentResModelDart.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }
}
