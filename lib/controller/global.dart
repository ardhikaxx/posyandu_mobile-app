import 'package:posyandu_app/controller/auth_controller.dart';
import 'package:get/get.dart';

class Global {
  static Future<void> init() async {
    Get.lazyPut(() => AuthController());
  }
}