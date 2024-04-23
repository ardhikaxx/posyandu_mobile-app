import 'package:posyandu_app/controller/AuthController.dart';
import 'package:get/get.dart';

class Global {
  static Future<void> init() async {
    Get.lazyPut(() => AuthController());
  }
}