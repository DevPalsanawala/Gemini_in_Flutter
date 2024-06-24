import 'package:get/get.dart';
import 'package:myapp/src/screens/authwrapper/authwrapper.dart';

class SplashAnimationController extends GetxController {
  static SplashAnimationController get instance => Get.find();
  RxBool animated = false.obs;

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    animated.value = true;
    await Future.delayed(const Duration(milliseconds: 4000));
    Get.offAll(AuthWrapper());
  }
}
