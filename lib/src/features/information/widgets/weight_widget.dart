import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travsy/src/common/widgets/custom_button.dart';
import 'package:travsy/src/features/information/controllers/information_controller.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';
import 'package:wheel_slider/wheel_slider.dart';

class WeightWidget extends StatefulWidget {
  const WeightWidget({super.key});

  @override
  State<WeightWidget> createState() => _WeightWidgetState();
}

class _WeightWidgetState extends State<WeightWidget> {
  int selectedMetricIndex = 41;
  int selectedImperialIndex = 81;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Gap(60),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: CustomButton(
              title: "Metric",
              onPressed: () {
                setState(() {
                  selectedMetricIndex = 41;
                  InformationController.selectedUnit!.value = "metric";
                  InformationController.selectedWeight =
                      selectedMetricIndex - 1 + 30;
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
                  selectedImperialIndex = 81;
                  InformationController.selectedUnit!.value = "imperial";
                  InformationController.selectedWeight =
                      selectedImperialIndex - 1 + 60;
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
              isGradient:
                  InformationController.selectedUnit!.value == "imperial",
            ),
          )
        ],
      ),
      const Gap(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.arrow_drop_down_rounded,
            color: zPrimaryColor,
            size: 50,
          ),
        ],
      ),
      const Gap(5),
      if (InformationController.selectedUnit!.value == "metric")
        Container(
          height: 180.01,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 180,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimensions.zButtonRadiusLarge),
                  color: zPrimaryColor.withOpacity(0.35),
                ),
              ),
              SizedBox(
                height: 180,
                child: WheelSlider.customWidget(
                  initValue: selectedMetricIndex - 1,
                  onValueChanged: (value) {
                    setState(() {
                      selectedMetricIndex = value + 30;
                      InformationController.selectedWeight =
                          selectedMetricIndex;
                    });
                  },
                  totalCount:
                      InformationController.instance.weightInKgList.length,
                  isInfinite: false,
                  showPointer: false,
                  itemSize: 120,
                  children: [
                    for (int i = 30;
                        i <
                            InformationController
                                    .instance.weightInKgList.length +
                                30;
                        i++)
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: i.toString(),
                                  style: TextStyle(
                                    color: i == selectedMetricIndex
                                        ? zTextColor
                                        : zTextColor.withOpacity(0.5),
                                    fontSize: 40,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                TextSpan(
                                  text: " kg",
                                  style: TextStyle(
                                    color: i == selectedMetricIndex
                                        ? zTextColor
                                        : zTextColor.withOpacity(0.5),
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      if (InformationController.selectedUnit!.value != "metric")
        Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 180,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimensions.zButtonRadiusLarge),
                  color: zPrimaryColor.withOpacity(0.35),
                ),
              ),
              Container(
                height: 180,
                child: WheelSlider.customWidget(
                  initValue: selectedImperialIndex - 1,
                  onValueChanged: (value) {
                    setState(() {
                      selectedImperialIndex = value + 60;
                      InformationController.selectedWeight =
                          selectedImperialIndex;
                      print(selectedImperialIndex);
                    });
                  },
                  totalCount:
                      InformationController.instance.weightInLbsList.length,
                  isInfinite: false,
                  showPointer: false,
                  itemSize: 120,
                  children: [
                    for (int i = 60;
                        i <
                            InformationController
                                    .instance.weightInLbsList.length +
                                60;
                        i++)
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: i.toString(),
                                  style: TextStyle(
                                    color: i == selectedImperialIndex
                                        ? zTextColor
                                        : zTextColor.withOpacity(0.5),
                                    fontSize: 40,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                TextSpan(
                                  text: " lb",
                                  style: TextStyle(
                                    color: i == selectedImperialIndex
                                        ? zTextColor
                                        : zTextColor.withOpacity(0.5),
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
    ]);
  }
}
