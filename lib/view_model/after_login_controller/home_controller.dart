import 'package:eye_hospital/data/api_response.dart';
import 'package:eye_hospital/model/response/doctor_res/doctor_list_res_model.dart';
import 'package:eye_hospital/model/response/product_res/product_res_model.dart';
import 'package:eye_hospital/repo/doctor_repo.dart';
import 'package:eye_hospital/repo/product_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTopDoctor();
    getTopProduct();
  }

  final searchDoctorCtr = TextEditingController();

  // top doctor

  var topDoctor = ApiResponse<DoctorListResModel>.completed(null).obs;
  final _repo = DoctorRepo();

  Future<void> getTopDoctor() async {
    topDoctor.value = ApiResponse.loading();
    try {
      final res = await _repo.topDoctor();
      topDoctor.value = ApiResponse.completed(res);
    } catch (e) {
      topDoctor.value = ApiResponse.error(e.toString());
    }
  }

  //==================== Top Products=========================

  var topProduct = ApiResponse<ProductResModelDart>.completed(null).obs;
  final _product = ProductRepo();

  Future<void> getTopProduct() async {
    topProduct.value = ApiResponse.loading();
    try {
      final res = await _product.topProduct();
      topProduct.value = ApiResponse.completed(res);
    } catch (e) {
      topProduct.value = ApiResponse.error(e.toString());
    }
  }
}
