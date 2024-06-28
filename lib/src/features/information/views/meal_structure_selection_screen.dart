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
import 'package:travsy/src/features/information/domain/models/meal_model.dart';
import 'package:travsy/src/features/information/widgets/index_viewer_widget.dart';
import 'package:travsy/src/features/information/widgets/information_screen_appbar.dart';
import 'package:travsy/src/features/information/widgets/information_selector_button.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class MealStructureSelectionScreen extends StatefulWidget {
  bool isBackButtonVisible = false;
  bool isTitleEnabled = true;
  bool isAppbarTitleEnabled = false;

  MealStructureSelectionScreen({
    super.key,
    this.isBackButtonVisible = false,
    this.isTitleEnabled = true,
    this.isAppbarTitleEnabled = false,
  });

  @override
  State<MealStructureSelectionScreen> createState() =>
      _MealStructureSelectionScreenState();
}

class _MealStructureSelectionScreenState
    extends State<MealStructureSelectionScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    InformationController.selectedMealStructure = MealModel(
      title: "initial",
      image: "",
      isSelected: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: zBackgroundColor,
        appBar: !widget.isAppbarTitleEnabled
            ? AppBarWidget(
                title: AppLocalizations.of(context)!.activityAppbarTitle,
                isTitleEnabled: widget.isAppbarTitleEnabled,
              )
            : AppBar(
                title: Text(
                  AppLocalizations.of(context)!.mealAppbarTitle,
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
                  selectedIndex: 8,
                ),
              const Gap(15),
              if (widget.isTitleEnabled)
                MultiColorTextSectionWidget(
                  title1: AppLocalizations.of(context)!.mealTitle1,
                  title2: AppLocalizations.of(context)!.mealTitle2,
                  isTitle2Color: true,
                  description:
                      AppLocalizations.of(context)!.activityDescription,
                  descriptionStyle: TextStyle(
                    color: zTextColor.withOpacity(0.5),
                    fontSize: 15,
                  ),
                ),
              if (widget.isTitleEnabled) const Gap(40),
              for (int i = 0;
                  i < InformationController.instance.mealList.length;
                  i++)
                InkWell(
                  onTap: () {
                    setState(() {
                      if (!InformationController
                          .instance.mealList[i].isSelected) {
                        InformationController.instance.mealList[i].isSelected =
                            true;
                        InformationController.selectedMealStructure =
                            InformationController.instance.mealList[i];
                      }
                      for (int j = 0;
                          j < InformationController.instance.mealList.length;
                          j++) {
                        if (j != i) {
                          InformationController
                              .instance.mealList[j].isSelected = false;
                        }
                      }
                    });
                    print(InformationController.selectedMealStructure.title
                        .toString());
                  },
                  child: InformationSelectorButton(
                    title: InformationController.instance.mealList[i].title,
                    image: InformationController.instance.mealList[i].image,
                    widget: InformationController
                        .instance.mealList[i].descriptionWidget,
                    isSelected:
                        InformationController.instance.mealList[i].isSelected,
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
                          for (int i = 0;
                              i <
                                  InformationController
                                      .instance.mealList.length;
                              i++) {
                            if (InformationController
                                .instance.mealList[i].isSelected) {
                              InformationController.selectedMealStructure =
                                  InformationController.instance.mealList[i];
                            }
                          }
                          if (InformationController
                                  .selectedMealStructure.title ==
                              "initial") {
                            CustomSnackBarService().showWarningSnackBar(
                                message: "Please select a meal structure");
                            return;
                          } else {
                            ShowPopup().showMealGenerationPopup(
                              context: context,
                              onContinue: () async {
                                if (await InformationController.instance
                                        .updateMealStructure(
                                            mealModel: InformationController
                                                .selectedMealStructure) ==
                                    false) {
                                  CustomSnackBarService().showErrorSnackBar(
                                    message: "Failed to update meal structure",
                                  );
                                  return;
                                }
                                CommonController.instance.generateNewMeals();
                                CustomSnackBarService().showSuccessSnackBar(
                                  message:
                                      "Meal structure updated successfully",
                                );
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                      );
                    }
                  }),
                ),
              )
            : null);
  }
}
