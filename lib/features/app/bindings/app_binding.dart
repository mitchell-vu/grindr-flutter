import 'package:get/get.dart';
import 'package:fluttr/features/app/controllers/app_controller.dart';
import 'package:fluttr/features/home/controllers/home_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppController>(() => AppController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
