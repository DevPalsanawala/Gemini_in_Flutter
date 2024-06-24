import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myapp/src/comman_widgets/formheader.dart';
import 'package:myapp/src/constants/color.dart';
import 'package:myapp/src/constants/size.dart';
import 'package:myapp/src/controller/signup/singup_controller.dart';
import 'package:myapp/src/screens/login/login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    final size = mediaquery.size;
    final brightness = mediaquery.platformBrightness;
    final isDarkmode = brightness == Brightness.dark;
    final controller = Get.put(SignupController());
    final formkey = GlobalKey<FormState>();
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(ddefaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormHeader(
                size: size,
                image: "assets/images/welcome.png",
                title: "Sign-up",
                subtitle: "Create your profile to start your journey... ",
              ),
              const SizedBox(height: dFormHeight - 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: dFormHeight - 10),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: controller.name,
                        decoration: const InputDecoration(
                          labelText: "Name",
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: dFormHeight - 15),
                      TextFormField(
                        controller: controller.phoneNo,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: "Phone",
                          prefixIcon: Icon(Icons.phone_outlined),
                        ),
                      ),
                      const SizedBox(height: dFormHeight - 15),
                      TextFormField(
                        controller: controller.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: dFormHeight - 15),
                      Obx(
                        () => TextFormField(
                          controller: controller.password,
                          obscureText: controller.obsecure.value,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.numbers_outlined),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.isvisible();
                              },
                              icon: Icon(controller.obsecure.value
                                  ? LineAwesomeIcons.eye_solid
                                  : LineAwesomeIcons.eye_slash),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: dFormHeight),
                      Obx(
                        () => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // if (_formkey.currentState!.validate()) {
                              final email = controller.email.text.trim();
                              final password = controller.password.text.trim();
                              final name = controller.name.text.trim();
                              final phoneNo = controller.phoneNo.text.trim();

                              controller.registerUser(
                                  email, password, name, phoneNo, context);
                              // }
                            },
                            child: controller.isLoading.value
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3.0,
                                            color: isDarkmode
                                                ? Colors.black87
                                                : dPrimaryColor,
                                          )),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Loading...".toUpperCase(),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  )
                                : Text(
                                    "Signup".toUpperCase(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: dFormHeight - 20),
                      GestureDetector(
                        onTap: () => Get.to(const LoginScreen()),
                        child: Text.rich(
                          TextSpan(
                              text: "Already have an account?  ",
                              style: Theme.of(context).textTheme.bodyText1,
                              children: const [
                                TextSpan(
                                  text: "Login",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
