import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/src/constants/size.dart';
import 'package:myapp/src/controller/splash/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashAnimationController());
    controller.startAnimation();
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(ddefaultSize),
          child: Obx(
            () => Center(
              child: AnimatedOpacity(
                opacity: controller.animated.value ? 1 : 0,
                duration: const Duration(milliseconds: 3000),
                child: const Image(
                  image: AssetImage("assets/images/splash.png"),
                  height: 200,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
