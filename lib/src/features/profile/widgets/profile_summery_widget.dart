import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travsy/src/features/profile/controllers/profile_controller.dart';
import 'package:travsy/src/utils/colors.dart';

class ProfileSummeryWidget extends StatelessWidget {
  const ProfileSummeryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 70,
          width: 70,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: FancyShimmerImage(
              imageUrl:
                  ProfileController.instance.profileModel.data!.image ?? '',
              height: 70,
              width: 70,
              boxFit: BoxFit.cover,
              errorWidget: Container(
                decoration: BoxDecoration(
                  color: zPrimaryColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: zBackgroundColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: zPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Gap(20),
        Text(
          ProfileController.userFullName,
          style: TextStyle(
            color: zTextColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
          ),
        ),
        const Gap(4),
        if (ProfileController.instance.profileModel.data!.referral != "null")
          Text(
            "#${ProfileController.instance.profileModel.data!.referral}",
            style: TextStyle(
              color: zTextColor.withOpacity(0.5),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
          ),

        // Text(
        //   "#${ProfileController.instance.profileModel.data!.id.toString()}",
        //   style: TextStyle(
        //     color: zTextColor.withOpacity(0.5),
        //     fontSize: 14,
        //     fontWeight: FontWeight.w600,
        //     fontStyle: FontStyle.italic,
        //   ),
        // ),
        if (ProfileController.instance.profileModel.data!.referral != "null")
          const Gap(20),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: zTextColor.withOpacity(0.5),
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
            children: [
              TextSpan(
                text: "${ProfileController.userAge}",
                style: TextStyle(
                  color: zTextColor,
                ),
              ),
              TextSpan(
                text: "yo    ",
              ),
              TextSpan(
                text: (ProfileController.instance.profileModel.data!.weight!
                        .toInt())
                    .toString(),
                style: TextStyle(
                  color: zTextColor,
                ),
              ),
              TextSpan(
                text: "kg    ",
              ),
              TextSpan(
                text: (ProfileController.instance.profileModel.data!.height!)
                    .toString(),
                style: TextStyle(
                  color: zTextColor,
                ),
              ),
              TextSpan(
                text: "cm",
              ),
            ],
          ),
        ),
        const Gap(20),
      ],
    );
  }
}
