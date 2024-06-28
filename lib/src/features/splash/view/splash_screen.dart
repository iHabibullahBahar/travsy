import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travsy/global.dart';
import 'package:travsy/src/features/auth/views/sign_in_screen.dart';
import 'package:travsy/src/features/navigation_bar/views/navigation_bar_screen.dart';
import 'package:travsy/src/features/onboarding/views/onboarding_screen.dart';
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
      // GlobalStorage.instance.isNotFirstTime == false
      //     ? Get.offAll(() => OnboardingScreen())
      //     : GlobalStorage.instance.isLogged == false
      //         ? Get.offAll(() => SignInScreen())
      //         : AuthController.instance.validateUser();
      // Get.offAll(() => GlobalStorage.instance.isNotFirstTime == false
      //     ? OnboardingScreen()
      //     : !GlobalStorage.instance.isLogged
      //         ? SignInScreen()
      //         : NavigationBarScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: zWhiteColor,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Text(
            //       zAppName,
            //       style: TextStyle(
            //         fontSize: 35,
            //         color: zBlackColor,
            //         fontWeight: FontWeight.bold,
            //         fontStyle: FontStyle.italic,
            //       ),
            //     ),
            //   ],
            // ),
            Image.asset(
              zAppLogo,
              height: 200,
              width: 200,
            ),
            const Positioned(
              bottom: 0,
              child: SafeArea(
                minimum: EdgeInsets.only(bottom: 20),
                child: CircularProgressIndicator(
                  color: zPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
