import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class TripWidget extends StatelessWidget {
  const TripWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: zWhiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: zBlackColor.withOpacity(0.1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            Dimensions.zDefaultPadding,
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  imageUrl:
                      "https://images.unsplash.com/photo-1604999333679-b86d54738315?q=80&w=2825&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                  width: 80,
                  height: 80,
                  boxFit: BoxFit.cover,
                ),
              ),
              Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: FancyShimmerImage(
                      imageUrl:
                          "https://images.unsplash.com/photo-1604999333679-b86d54738315?q=80&w=2825&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      width: 20,
                      height: 20,
                      boxFit: BoxFit.cover,
                    ),
                  ),
                  Gap(5),
                  Container(
                    width: Get.width - 4 * Dimensions.zDefaultPadding - 130,
                    child: Text(
                      "Abu Dhabi, UAE",
                      style: TextStyle(
                        color: zTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Gap(8),
                  Text(
                    "01 Jul, 2024",
                    style: TextStyle(
                      color: zTextColor.withOpacity(0.8),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Gap(8),
                  Row(
                    children: [
                      Icon(
                        Icons.backpack_sharp,
                        color: zGraySwatch[400],
                        size: 14,
                      ),
                      Gap(5),
                      Text(
                        "solo",
                        style: TextStyle(
                          color: zTextColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     color: zGraySwatch[50],
              //     borderRadius: BorderRadius.circular(100),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(10.0),
              //     child: Icon(
              //       Icons.arrow_forward_ios,
              //       color: zGraySwatch[400],
              //       size: 16,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
