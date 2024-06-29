import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travsy/src/features/auth/controllers/auth_controller.dart';
import 'package:travsy/src/features/profile/controllers/profile_controller.dart';
import 'package:travsy/src/features/profile/widgets/help_and_setting_widget.dart';
import 'package:travsy/src/features/profile/widgets/profile_widget.dart';
import 'package:travsy/src/features/profile/widgets/your_voice_widget.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: SafeArea(
          child: SizedBox(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
        child: Obx(
          () {
            if (ProfileController.instance.isProfileFetching.value) {
              return const Center(
                child: CircularProgressIndicator(
                  color: zPrimaryColor,
                ),
              );
            }
            return ListView(
              children: [
                ProfileWidget(),
                const Gap(20),
                HelpAndSettingWidget(title: "Help & Settings"),
                Gap(10),
                YourVoiceWidget(title: "Your Voice"),
                Gap(40),
                InkWell(
                  onTap: () {
                    ///TODO: Implement Sign Out
                    AuthController.instance.signOut();
                  },
                  child: Text(
                    "Sign Out",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
