import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travsy/src/common/widgets/custom_button.dart';
import 'package:travsy/src/features/auth/views/sign_in_screen.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class ProfileDeletionCompleteScreen extends StatelessWidget {
  const ProfileDeletionCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBackgroundColor,
      appBar: AppBar(
          backgroundColor: zBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: zBlackColor),
          title: const Text(
            'Complete',
            style: TextStyle(
              color: zBlackColor,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
        child: ListView(
          children: [
            Text(
              "Your account has been deleted successfully. Thank you for using our app. We hope to see you again.",
              style: const TextStyle(
                color: zBlackColor,
                fontSize: 14,
              ),
            ),
            Gap(20),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 30,
              height: 50,
              child: CustomButton(
                radius: 8,
                title: "Go back to sign in",
                onPressed: () {
                  Get.deleteAll();
                  Get.offAll(() => const SignInScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
