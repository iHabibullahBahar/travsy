import 'package:flutter/material.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class AuthHeaderWidget extends StatelessWidget {
  String title;
  String description;

  AuthHeaderWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: zPrimaryColor,
          ),
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Dimensions.fontSizeDefault,
            color: zTextColorLight,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
