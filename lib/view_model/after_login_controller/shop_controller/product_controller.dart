import 'package:eye_hospital/res/app_images.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxInt selectedCategory = 0.obs;

  final categories = ["Spectacles", "Lenses", "Frames"];

  final List<Map<String, String>> glassesProducts = List.generate(
    8,
    (index) => {
      "title": "Classic Spectacles",
      "price": "Rs. 250",
      "image": AppImages.on3,
    },
  );

  final List<Map<String, String>> lensProducts = List.generate(
    8,
    (index) => {
      "title": "Blue Color Lens",
      "price": "Rs. 300",
      "image": AppImages.lens,
    },
  );

  final List<Map<String, String>> frameProducts = List.generate(
    8,
    (index) => {
      "title": "Premium Frame",
      "price": "Rs. 400",
      "image": AppImages.frame,
    },
  );

  /// 👇 this will change automatically
  List<Map<String, String>> get products {
    if (selectedCategory.value == 0) {
      return glassesProducts;
    } else if (selectedCategory.value == 1) {
      return lensProducts;
    } else {
      return frameProducts;
    }
  }
}
