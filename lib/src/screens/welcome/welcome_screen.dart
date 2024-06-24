import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:myapp/src/constants/size.dart';
import 'package:myapp/src/screens/Home/home_screen.dart';
import 'package:myapp/src/screens/login/login_screen.dart';
import 'package:myapp/src/screens/signup/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(ddefaultSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image(
                    image: const AssetImage("assets/images/welcome.png"),
                    height: size.height * 0.40,
                  ),
                  // const Divider(),
                  Column(
                    children: [
                      Text(
                        "Welcome to My App!",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        textAlign: TextAlign.center,
                        "Let's Build Awesome App With Flutter, Flutter Is Best For Development Tool.",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Get.to(const LoginScreen());
                          },
                          child: Text(
                            "Login".toUpperCase(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(const SignupScreen());
                          },
                          child: Text(
                            "Signup".toUpperCase(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
