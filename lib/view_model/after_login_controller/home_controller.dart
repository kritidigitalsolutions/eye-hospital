import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final searchDoctorCtr = TextEditingController();
}

// ---------------------------------------------------
// My cart
//----------------------------------------------------

class MyCartController extends GetxController {
  RxList<int> productCount = <int>[].obs;

  void initCount(int length) {
    productCount.value = List.generate(length, (index) => 1);
  }

  void increase(int index) {
    productCount[index]++;
  }

  void decrease(int index) {
    if (productCount[index] > 1) {
      productCount[index]--;
    }
  }
}
