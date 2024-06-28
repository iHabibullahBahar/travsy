import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travsy/src/common/services/custom_snackbar_service.dart';
import 'package:travsy/src/common/widgets/custom_circular_progress_button.dart';
import 'package:travsy/src/features/information/controllers/information_controller.dart';
import 'package:travsy/src/features/information/views/activity_level_selection_screen.dart';
import 'package:travsy/src/features/information/views/age_input_screen.dart';
import 'package:travsy/src/features/information/views/data_preparing_from_info_screeen.dart';
import 'package:travsy/src/features/information/views/dietary_selection-screen.dart';
import 'package:travsy/src/features/information/views/gender_selection_screen.dart';
import 'package:travsy/src/features/information/views/goal_selector_screen.dart';
import 'package:travsy/src/features/information/views/height_input_screen.dart';
import 'package:travsy/src/features/information/views/meal_structure_selection_screen.dart';
import 'package:travsy/src/features/information/views/weight_input_screen.dart';
import 'package:travsy/src/features/profile/controllers/profile_controller.dart';
import 'package:travsy/src/utils/colors.dart';

class InformationScreen extends StatefulWidget {
  InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  var informationController = Get.put(InformationController());
  int selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: InformationController.instance.selectedIndex,
          children: [
            DietarySelectionScreen(),
            GenderSelectionScreen(),
            AgeInputScreen(),
            HeightInputScreen(),
            WeightInputScreen(),
            ActivitySelectionScreen(),
            GoalSelectionScreen(),
            MealStructureSelectionScreen(),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: 110,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomCircularProgressButton(
                  progress: InformationController.progress.value,
                ),
                InkWell(
                  onTap: () async {
                    if (InformationController.instance.isDataUpdating.value) {
                      print("Data is updating. Please wait.");
                      return;
                    }

                    ///Check if the selected index is 0, then update the dietary list
                    if (InformationController.instance.selectedIndex == 0) {
                      if (await InformationController.instance.updateDietary(
                              dietList:
                                  InformationController.selectedDietList) ==
                          false) {
                        CustomSnackBarService().showErrorSnackBar(
                            message: "Failed to update dietary preferences");
                        return;
                      }
                    }

                    ///Check if the selected index is 1, then update the gender
                    else if (InformationController.instance.selectedIndex ==
                        1) {
                      if (InformationController.selectedGender == "initial") {
                        CustomSnackBarService().showWarningSnackBar(
                            message: "Please select your gender");
                        return;
                      } else {
                        if (await InformationController.instance.updateGender(
                                gender: InformationController.selectedGender) ==
                            false) {
                          CustomSnackBarService().showErrorSnackBar(
                              message: "Failed to update gender");
                          return;
                        }
                      }
                    }

                    ///Check if the selected index is 2, then update the age
                    else if (InformationController.instance.selectedIndex ==
                        2) {
                      //check if the user age is less than 18
                      if ((InformationController.selectedDateOfBirth!
                                      .difference(DateTime.now())
                                      .inDays /
                                  365)
                              .abs() <=
                          7) {
                        CustomSnackBarService().showWarningSnackBar(
                            message: "Age should be greater than 7 years");
                        return;
                      } else {
                        if (await InformationController.instance.updateAge(
                                dob: DateFormat()
                                    .addPattern("yyyy-MM-dd")
                                    .format(InformationController
                                        .selectedDateOfBirth!)) ==
                            false) {
                          CustomSnackBarService().showErrorSnackBar(
                              message: "Failed to update age");
                          return;
                        }
                      }
                    }

                    ///Check if the selected index is 3, then update the height
                    else if (InformationController.instance.selectedIndex ==
                        3) {
                      if (InformationController.selectedUnit!.value ==
                          "imperial") {
                        InformationController.selectedHeight =
                            (InformationController.selectedHeight * 2.54)
                                .toInt();
                      }
                      if (await InformationController.instance.updateHeight(
                              height: InformationController.selectedHeight) ==
                          false) {
                        CustomSnackBarService().showErrorSnackBar(
                            message: "Failed to update height");
                        return;
                      } else {
                        InformationController.selectedUnit!.value = "metric";
                      }
                    }

                    ///Check if the selected index is 4, then update the weight
                    else if (InformationController.instance.selectedIndex ==
                        4) {
                      int weight = InformationController.selectedWeight;
                      if (InformationController.selectedUnit!.value ==
                          "imperial") {
                        weight =
                            (InformationController.selectedWeight * 0.453592)
                                .toInt();
                      }
                      if (await InformationController.instance
                              .updateWeight(weight: weight) ==
                          false) {
                        CustomSnackBarService().showErrorSnackBar(
                            message: "Failed to update weight");
                        return;
                      } else {}
                    }

                    ///Check if the selected index is 5, then update the activity level
                    else if (InformationController.instance.selectedIndex ==
                        5) {
                      if (InformationController
                              .selectedActivityLevel.endpoint ==
                          "initial") {
                        CustomSnackBarService().showWarningSnackBar(
                            message: "Please select an activity level");
                        return;
                      } else {
                        if (await InformationController.instance
                                .updateActivityLevel(
                                    level: InformationController
                                        .selectedActivityLevel.endpoint) ==
                            false) {
                          CustomSnackBarService().showErrorSnackBar(
                              message: "Failed to update activity level");
                          return;
                        }
                      }
                    }

                    ///Check if the selected index is 6, then update the goal
                    else if (InformationController.instance.selectedIndex ==
                        6) {
                      if (InformationController.selectedGoal == "initial") {
                        CustomSnackBarService().showWarningSnackBar(
                            message: "Please select a goal");
                        return;
                      } else {
                        if (await InformationController.instance.updateGoals(
                                goal: InformationController.selectedGoal) ==
                            false) {
                          CustomSnackBarService().showErrorSnackBar(
                              message: "Failed to update goal");
                          return;
                        } else {
                          ///TODO Need to remove
                        }
                      }
                    }

                    ///Check if the selected index is 7, then update the meal structure
                    else if (InformationController.instance.selectedIndex ==
                        7) {
                      if (InformationController.selectedMealStructure.title ==
                          "initial") {
                        CustomSnackBarService().showWarningSnackBar(
                            message: "Please select a meal structure");
                        return;
                      } else {
                        if (await InformationController.instance
                                .updateMealStructure(
                                    mealModel: InformationController
                                        .selectedMealStructure) ==
                            false) {
                          return;
                        } else {
                          ///TODO Need to remove
                          //return;
                        }
                      }
                    }

                    setState(() {
                      if (InformationController.instance.selectedIndex + 1 >
                          7) {
                        Get.to(() => DataPreparingFromInfo());
                      }
                      if (InformationController.instance.selectedIndex <= 7) {
                        InformationController.instance.selectedIndex++;
                        if (InformationController.progress.value + 0.120 >= 1) {
                          InformationController.progress.value = 1.0;
                        } else {
                          InformationController.progress.value += 0.120;
                        }
                      }
                    });
                  },
                  child: Container(
                    height: 65,
                    width: 65,
                    decoration: const BoxDecoration(
                      gradient: zPrimaryGradientTopToBottom,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: InformationController.progress.value >= 1
                          ? Icon(
                              Icons.check_rounded,
                              color: zWhiteColor,
                              size: 30,
                            )
                          : const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: zWhiteColor,
                              size: 30,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
