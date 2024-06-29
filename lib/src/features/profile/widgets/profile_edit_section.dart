import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travsy/src/features/profile/views/update_name_screen.dart';
import 'package:travsy/src/features/profile/widgets/profile_custom_button.dart';
import 'package:travsy/src/utils/colors.dart';

class ProfileEditSection extends StatelessWidget {
  const ProfileEditSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: zGraySwatch[200]!,
          )),
      child: Column(
        children: [
          ProfileCustomButton(
            icon: Icons.person,
            title: "Update Name",
            onPressed: () {
              Get.to(() => UpdateNameScreen());
            },
            isHorizontalDivider: false,
          ),
        ],
      ),
    );
  }
}
