import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class InformationSelectorButton extends StatefulWidget {
  String title;
  String image;
  Widget widget;
  bool isSelected = false;
  InformationSelectorButton({
    required this.title,
    required this.image,
    required this.widget,
    this.isSelected = false,
  });

  @override
  State<InformationSelectorButton> createState() =>
      _InformationSelectorButtonState();
}

class _InformationSelectorButtonState extends State<InformationSelectorButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Dimensions.zButtonRadiusLarge,
          ),
          border: Border.all(
            color: widget.isSelected
                ? zPrimaryColor.withOpacity(0.35)
                : zPrimaryColor,
            width: 0.5,
          ),
          color:
              widget.isSelected ? zPrimaryColor.withOpacity(0.35) : zWhiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
          child: Row(
            children: [
              SizedBox(
                width: Get.width - Dimensions.zDefaultPadding * 4 - 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: zTextColor,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Gap(5),
                    widget.widget
                  ],
                ),
              ),
              const Spacer(),
              // Image.asset(
              //   widget.image,
              //   height: 75,
              //   width: 75,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
