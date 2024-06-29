import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travsy/src/common/widgets/custom_button.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBackgroundColor,
      appBar: AppBar(
          backgroundColor: zBackgroundColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: zBlackColor),
          title: const Text(
            'Delete Account',
            style: TextStyle(
              color: zBlackColor,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
        child: ListView(
          children: [
            Text(
              "If you delete your account, all of your previous records will be deleted and you will not be able to recover them. But you can create a new account anytime.",
              style: const TextStyle(
                color: zBlackColor,
                fontSize: 14,
              ),
            ),
            Gap(20),
            Text(
              "Are you sure you want to delete your account?",
              style: const TextStyle(
                color: zErrorSwatch,
                fontSize: 14,
              ),
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 30,
                  height: 50,
                  child: CustomButton(
                    radius: 8,
                    title: "Cancel",
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                const Gap(10),
              ],
            )
          ],
        ),
      ),
    );
  }
}
