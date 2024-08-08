import 'package:get/get.dart';
import 'package:products/controller/cart_controller.dart';
import 'package:products/controller/product_info_controller.dart';

class MainBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CartController(),fenix: true);

  }

}
class ProductInfoBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProductInfoController(),fenix: true );
  }

}