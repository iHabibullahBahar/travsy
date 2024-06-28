import 'package:flutter/material.dart';
import 'package:travsy/src/features/information/controllers/information_controller.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

AppBar AppBarWidget({
  bool isBackButtonVisible = false,
  String title = "",
  bool isTitleEnabled = true,
  bool isFromEditScreen = false,
}) {
  return AppBar(
    title: isTitleEnabled
        ? Text(
            title,
            style: TextStyle(
              color: zTextColor,
              fontStyle: FontStyle.italic,
              fontSize: Dimensions.zAppBarTitleFontSize,
            ),
          )
        : null,
    backgroundColor: zWhiteColor,
    elevation: 0,
    leading: InkWell(
      onTap: () {
        if (!isFromEditScreen) {
          if (InformationController.instance.selectedIndex > 0) {
            InformationController.instance.selectedIndex--;
            InformationController.progress.value -= 0.125;
          }
        }
      },
      child: const Icon(
        Icons.arrow_back_ios,
        color: zPrimaryColor,
      ),
    ),
  );
}
