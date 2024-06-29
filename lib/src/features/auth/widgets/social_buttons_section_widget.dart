import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travsy/src/features/auth/controllers/auth_controller.dart';
import 'package:travsy/src/features/auth/widgets/social_button.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/images.dart';

class SocialButtonSectionWidget extends StatelessWidget {
  const SocialButtonSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialButton(
              icon: zGoogleIcon,
              title: 'Continue with Google',
              onPressed: () async {
                await AuthController.instance.signInWithGoogle();
              },
            ),
            if (Platform.isIOS) Gap(10),
            if (Platform.isIOS)
              SocialButton(
                title: 'Continue with Apple',
                backgroundColor: Colors.transparent,
                textColors: zWhiteColor,
                borderColor: zPrimaryColor,
                onPressed: () {
                  /// TODO Implement Apple Login
                },
                icon: zAppleIcon,
              )
          ],
        ),
      ],
    );
  }
}
