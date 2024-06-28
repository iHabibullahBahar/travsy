import 'package:flutter/material.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class DietaryElementWidget extends StatefulWidget {
  String title;
  String image;
  final bool isSelected;
  final bool isDeactivated;

  DietaryElementWidget({
    required this.title,
    required this.image,
    this.isSelected = false,
    this.isDeactivated = false,
  });

  @override
  State<DietaryElementWidget> createState() => _DietaryElementWidgetState();
}

class _DietaryElementWidgetState extends State<DietaryElementWidget> {
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
          borderRadius: BorderRadius.circular(Dimensions.zButtonRadiusLarge),
          border: Border.all(
            color: widget.isSelected
                ? zPrimaryColor.withOpacity(0.35)
                : zPrimaryColor,
            width: 0.5,
          ),
          color: widget.isSelected
              ? zPrimaryColor.withOpacity(0.35)
              : widget.isDeactivated
                  ? zGraySwatch[100]
                  : zWhiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.zDefaultPadding,
          ),
          child: Row(
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: widget.isSelected
                      ? zTextColor
                      : zTextColor.withOpacity(0.5),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Spacer(),
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
