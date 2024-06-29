import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travsy/global.dart';
import 'package:travsy/src/features/auth/views/sign_in_screen.dart';
import 'package:travsy/src/features/navigation_bar/views/navigation_bar_screen.dart';
import 'package:travsy/src/features/onboarding/views/onboarding_screen.dart';
import 'package:travsy/src/utils/app_constants.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (GlobalStorage.instance.isNotFirstTime == false) {
        Get.offAll(() => OnboardingScreen());
      } else if (GlobalStorage.instance.isLogged == false) {
        Get.offAll(() => SignInScreen());
      } else {
        Get.offAll(() => NavigationBarScreen());
      }
      GlobalStorage.instance.isNotFirstTime == false
          ? Get.offAll(() => OnboardingScreen())
          : GlobalStorage.instance.isLogged == false
              ? Get.offAll(() => SignInScreen())
              : Get.offAll(() => NavigationBarScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(
          bottom: 20,
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: zPrimaryColor,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: Get.height * 0.8,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      zAppLogo,
                      height: 100,
                    ),
                    Gap(10),
                    Text(
                      zAppName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Make your travel easy and fun!",
                      style: TextStyle(
                        fontSize: 14,
                        color: zGraySwatch[500],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
