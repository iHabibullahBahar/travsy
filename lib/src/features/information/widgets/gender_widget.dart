import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class GenderWidget extends StatelessWidget {
  String title;
  String image;
  bool isSelected = false;
  GenderWidget({
    required this.title,
    required this.image,
    this.isSelected = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: zPrimaryColor.withOpacity(0.35),
          width: 0.5,
        ),
        color: isSelected ? zPrimaryColor.withOpacity(0.35) : zWhiteColor,
      ),
      height: 80,
      width: Get.width / 2 - Dimensions.zDefaultPadding * 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(
          //   image,
          //   height: 100,
          //   width: 100,
          // ),
          //const Gap(10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
