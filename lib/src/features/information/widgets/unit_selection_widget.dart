import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travsy/src/common/widgets/custom_button.dart';
import 'package:travsy/src/features/information/controllers/information_controller.dart';
import 'package:travsy/src/utils/colors.dart';

class UnitSelectionWidget extends StatefulWidget {
  const UnitSelectionWidget({super.key});

  @override
  State<UnitSelectionWidget> createState() => _UnitSelectionWidgetState();
}

class _UnitSelectionWidgetState extends State<UnitSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: CustomButton(
            title: "Metric",
            onPressed: () {
              setState(() {
                InformationController.selectedUnit!.value = "metric";
              });
            },
            border: Border.all(
              color: InformationController.selectedUnit!.value == "metric"
                  ? Colors.transparent
                  : zBlackColor.withOpacity(0.5),
              width: 0.5,
            ),
            height: 35,
            textStyle: TextStyle(
              color: InformationController.selectedUnit!.value == "metric"
                  ? zTextColorLight
                  : zTextColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            isGradient: InformationController.selectedUnit!.value == "metric",
            horizontalPadding: 10,
          ),
        ),
        const Gap(10),
        SizedBox(
          width: 80,
          child: CustomButton(
            title: "Imperial",
            horizontalPadding: 10,
            onPressed: () {
              setState(() {
                InformationController.selectedUnit!.value = "imperial";
              });
            },
            height: 35,
            textStyle: TextStyle(
              color: InformationController.selectedUnit!.value == "imperial"
                  ? zTextColorLight
                  : zTextColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            border: Border.all(
              color: InformationController.selectedUnit!.value == "imperial"
                  ? Colors.transparent
                  : zBlackColor.withOpacity(0.5),
              width: 0.5,
            ),
            isGradient: InformationController.selectedUnit!.value == "imperial",
          ),
        )
      ],
    );
  }
}
