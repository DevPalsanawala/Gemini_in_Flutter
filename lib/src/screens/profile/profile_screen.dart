import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myapp/src/constants/color.dart';
import 'package:myapp/src/constants/size.dart';

import 'package:myapp/src/screens/profile/widget/profile_menu.dart';
import 'package:myapp/src/services/auth_service/auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authcontroller = Get.put(Authentication());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Profile"),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: ddefaultSize - 10, vertical: ddefaultSize),
          child: Obx(
            () => Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 2, color: dPrimaryColor),
                      ),
                      child: SizedBox(
                        width: 130,
                        height: 130,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: const Image(
                            image: AssetImage("assets/images/profile.png"),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 5,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.greenAccent,
                        ),
                        child: const Icon(
                          LineAwesomeIcons.pen_solid,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Text(
                      authcontroller.userData["Name"] ?? "Name",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      authcontroller.userData["Email"] ?? "Email",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                ProfileMenu(
                  title: "Settings",
                  icon: LineAwesomeIcons.cog_solid,
                  onPress: () {},
                ),
                ProfileMenu(
                  title: "Information",
                  icon: LineAwesomeIcons.info_solid,
                  onPress: () {},
                ),
                const Divider(),
                ProfileMenu(
                  title: "Logout",
                  icon: LineAwesomeIcons.sign_out_alt_solid,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    authcontroller.logout();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
