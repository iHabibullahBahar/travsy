import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travsy/src/common/contollers/common_controller.dart';
import 'package:travsy/src/common/services/custom_snackbar_service.dart';
import 'package:travsy/src/common/services/show_popup.dart';
import 'package:travsy/src/common/widgets/custom_button.dart';
import 'package:travsy/src/common/widgets/custom_shimmer_button.dart';
import 'package:travsy/src/common/widgets/multicolor_text_section_widget.dart';
import 'package:travsy/src/features/information/controllers/information_controller.dart';
import 'package:travsy/src/features/information/widgets/index_viewer_widget.dart';
import 'package:travsy/src/features/information/widgets/information_screen_appbar.dart';
import 'package:travsy/src/features/information/widgets/information_selector_button.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class GoalSelectionScreen extends StatefulWidget {
  bool isBackButtonVisible = false;
  bool isTitleEnabled = true;
  bool isAppbarTitleEnabled = false;

  GoalSelectionScreen({
    super.key,
    this.isBackButtonVisible = false,
    this.isTitleEnabled = true,
    this.isAppbarTitleEnabled = false,
  });

  @override
  State<GoalSelectionScreen> createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  int selectedMetricIndex = 120;
  int selectedImperialIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    InformationController.selectedGoal = "initial";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBackgroundColor,
      appBar: !widget.isAppbarTitleEnabled
          ? AppBarWidget(
              title: AppLocalizations.of(context)!.goalAppbarTitle,
              isTitleEnabled: widget.isAppbarTitleEnabled,
            )
          : AppBar(
              title: Text(
                AppLocalizations.of(context)!.goalAppbarTitle,
                style: const TextStyle(
                  color: zTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
              backgroundColor: zBackgroundColor,
              elevation: 0,
              iconTheme: const IconThemeData(
                color: zPrimaryColor,
              ),
            ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeExtraLarge),
        child: ListView(
          children: [
            if (widget.isTitleEnabled)
              IndexViewWidget(
                selectedIndex: 7,
              ),
            const Gap(15),
            if (widget.isTitleEnabled)
              MultiColorTextSectionWidget(
                title1: AppLocalizations.of(context)!.goalTitle1,
                title2: AppLocalizations.of(context)!.goalTitle2,
                isTitle2Color: true,
                description: AppLocalizations.of(context)!.goalDescription,
                descriptionStyle: TextStyle(
                  color: zTextColor.withOpacity(0.5),
                  fontSize: 15,
                ),
              ),
            if (widget.isTitleEnabled) const Gap(40),
            for (int i = 0;
                i < InformationController.instance.goalList.length;
                i++)
              InkWell(
                onTap: () {
                  setState(() {
                    if (InformationController.instance.goalList[i].isSelected ==
                        false) {
                      InformationController.instance.goalList[i].isSelected =
                          true;
                      InformationController.selectedGoal =
                          InformationController.instance.goalList[i].endpoint;
                    }
                    for (int j = 0;
                        j < InformationController.instance.goalList.length;
                        j++) {
                      if (i != j) {
                        InformationController.instance.goalList[j].isSelected =
                            false;
                      }
                    }
                  });
                },
                child: InformationSelectorButton(
                  title: InformationController.instance.goalList[i].title,
                  image: InformationController.instance.goalList[i].image,
                  widget: Container(),
                  isSelected:
                      InformationController.instance.goalList[i].isSelected,
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: widget.isAppbarTitleEnabled
          ? SafeArea(
              minimum: const EdgeInsets.only(
                  left: Dimensions.paddingSizeExtraLarge,
                  right: Dimensions.paddingSizeExtraLarge,
                  bottom: Dimensions.paddingSizeExtraLarge),
              child: Container(
                child: Obx(() {
                  if (InformationController.instance.isDataUpdating.value) {
                    return CustomShimmerButton();
                  } else {
                    return CustomButton(
                      title: AppLocalizations.of(context)!.buttonUpdate,
                      onPressed: () async {
                        bool flag = false;
                        for (int i = 0;
                            i < InformationController.instance.goalList.length;
                            i++) {
                          if (InformationController
                                  .instance.goalList[i].isSelected ==
                              true) {
                            flag = true;
                            break;
                          }
                        }
                        if (flag != true) {
                          CustomSnackBarService().showWarningSnackBar(
                              message: "Please select a goal");
                          return;
                        } else {
                          ShowPopup().showMealGenerationPopup(
                              context: context,
                              onContinue: () async {
                                if (await InformationController.instance
                                        .updateGoals(
                                            goal: InformationController
                                                .selectedGoal) ==
                                    false) {
                                  CustomSnackBarService().showErrorSnackBar(
                                    message: "Failed to update goal",
                                  );
                                  return;
                                }
                                CommonController.instance.generateNewMeals();
                                CustomSnackBarService().showSuccessSnackBar(
                                  message: "Goal updated successfully",
                                );
                                Navigator.pop(context);
                              });
                        }
                      },
                    );
                  }
                }),
              ),
            )
          : null,
    );
  }
}
