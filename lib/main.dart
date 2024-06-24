import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/src/constants/api.dart';
import 'package:myapp/src/screens/splash/splash_screen.dart';
import 'package:myapp/src/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: GEMINI_API_KEY);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "MyApp",
      debugShowCheckedModeBanner: false,
      theme: DAppTheme.lighttheme,
      darkTheme: DAppTheme.darktheme,
      themeMode: ThemeMode.system,
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 800),
      home: const SplashScreen(),
    );
  }
}
