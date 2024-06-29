import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travsy/src/utils/colors.dart';

class SocialButton extends StatelessWidget {
  Function onPressed;
  String icon;
  String title;
  Color backgroundColor;
  Color textColors;
  Color borderColor;
  SocialButton(
      {Key? key,
      required this.onPressed,
      required this.icon,
      this.backgroundColor = zPrimaryColor,
      this.textColors = zTextColorLight,
      this.borderColor = zPrimaryColor,
      required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                height: 24,
                width: 24,
                color: zWhiteColor,
              ),
              Gap(10),
              Text(
                title,
                style: TextStyle(
                  color: zTextColorLight,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
