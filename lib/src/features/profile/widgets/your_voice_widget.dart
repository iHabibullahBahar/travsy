import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travsy/src/features/profile/widgets/profile_custom_button.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class YourVoiceWidget extends StatelessWidget {
  String title;
  YourVoiceWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: zGraySwatch[100]!,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(18),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.zDefaultPadding,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: zTextColor.withOpacity(0.5),
              ),
            ),
          ),
          const Gap(5),
          ProfileCustomButton(
            icon: Icons.feedback,
            title: "Share your feedback",
            isHorizontalDivider: true,
            onPressed: () {},
          ),
          ProfileCustomButton(
            icon: Icons.privacy_tip_sharp,
            title: "Rate us on App Store",
            isHorizontalDivider: true,
            onPressed: () {},
          ),
          ProfileCustomButton(
            icon: Icons.privacy_tip_sharp,
            title: "Contact Us",
            isHorizontalDivider: false,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
