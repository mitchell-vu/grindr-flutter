import 'package:get/get.dart';

class AppController extends GetxController {
  final RxInt selectedPageIndex = 0.obs;

  void changePage(int index) {
    selectedPageIndex.value = index;
  }
}
