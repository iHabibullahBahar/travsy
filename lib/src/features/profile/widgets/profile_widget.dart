import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travsy/src/features/profile/views/profile_edit_screen.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: zGraySwatch[100]!,
          )),
      child: Padding(
        padding: const EdgeInsets.only(
          top: Dimensions.zDefaultPadding,
          bottom: Dimensions.zDefaultPadding,
          left: Dimensions.zDefaultPadding,
          right: Dimensions.zDefaultPadding,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: zPrimaryColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: FancyShimmerImage(
                        imageUrl: "",
                        height: 80,
                        width: 80,
                        boxFit: BoxFit.cover,
                        errorWidget: Container(
                          color: zGraySwatch[50],
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: zPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(10),
            Text(
              "Khandoker Kafi Anan",
              style: const TextStyle(
                fontSize: 20,
                color: zTextColor,
              ),
            ),
            const Gap(20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Gap(2),
                      Icon(
                        CupertinoIcons.mail_solid,
                        color: zPrimaryColor.withOpacity(1),
                        size: 18,
                      ),
                      Gap(5),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "khandokeranan@gmail.com",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        CupertinoIcons.location_solid,
                        color: zPrimaryColor.withOpacity(1),
                        size: 20,
                      ),
                      Gap(5),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Dhaka, Bangladesh",
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => ProfileEditScreen());
                  },
                  child: Container(
                    height: 50,
                    width: Get.width - 4 * Dimensions.zDefaultPadding - 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: zPrimaryColor,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit,
                          color: zPrimaryColor,
                          size: 25,
                        ),
                        Gap(5),
                        Text(
                          "Edit Profile",
                          style: TextStyle(
                            color: zTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
