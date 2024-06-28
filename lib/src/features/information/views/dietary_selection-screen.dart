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
import 'package:travsy/src/features/information/widgets/dietary_element_widget.dart';
import 'package:travsy/src/features/information/widgets/index_viewer_widget.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class DietarySelectionScreen extends StatefulWidget {
  bool isBackButtonVisible = false;
  bool isTitleEnabled = true;
  bool isAppbarTitleEnabled = false;
  DietarySelectionScreen(
      {super.key,
      this.isBackButtonVisible = false,
      this.isTitleEnabled = true,
      this.isAppbarTitleEnabled = false});

  @override
  State<DietarySelectionScreen> createState() => _DietarySelectionScreenState();
}

class _DietarySelectionScreenState extends State<DietarySelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: widget.isBackButtonVisible,
        backgroundColor: zBackgroundColor,
        title: widget.isAppbarTitleEnabled
            ? Text(
                AppLocalizations.of(context)!.dietaryAppbarTitle,
                style: const TextStyle(
                  color: zTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              )
            : null,
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
                selectedIndex: 1,
              ),
            const Gap(15),
            if (widget.isTitleEnabled)
              MultiColorTextSectionWidget(
                title1: AppLocalizations.of(context)!.dietaryTitle1,
                title2: AppLocalizations.of(context)!.dietaryTitle2,
                isTitle2Color: true,
                description: AppLocalizations.of(context)!.dietaryDescription,
                descriptionStyle: TextStyle(
                  color: zTextColor.withOpacity(0.5),
                  fontSize: 15,
                ),
              ),
            if (widget.isTitleEnabled) const Gap(40),
            for (var i = 0;
                i < InformationController.instance.dietList.length;
                i++)
              InkWell(
                onTap: () {
                  if (InformationController
                      .instance.dietList[i].isDeactivated) {
                    CustomSnackBarService().showErrorSnackBar(
                      message: "Please unselect the no dietary option first",
                    );
                    return;
                  }
                  if (InformationController.instance.dietList[0].isSelected &&
                      i != 0) {
                    CustomSnackBarService().showErrorSnackBar(
                      message: "Please unselect the no dietary option first",
                    );
                    return;
                  }
                  if (InformationController.instance.dietList[i].endPoint ==
                      "none") {
                    InformationController.instance.setDietList(i);
                    setState(() {});
                    return;
                  }
                  if (!InformationController.instance.dietList[i].isSelected) {
                    InformationController.instance.dietList[i].isSelected =
                        true;
                    InformationController.selectedDietList.add(
                        InformationController.instance.dietList[i].endPoint);
                    print(InformationController.selectedDietList);
                  } else {
                    InformationController.instance.dietList[i].isSelected =
                        false;
                    InformationController.selectedDietList.remove(
                        InformationController.instance.dietList[i].endPoint);
                    print(InformationController.selectedDietList);
                  }
                  setState(() {});
                },
                child: DietaryElementWidget(
                  title: InformationController.instance.dietList[i].title,
                  image: InformationController.instance.dietList[i].image,
                  isSelected:
                      InformationController.instance.dietList[i].isSelected,
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
                        int selectCount = 0;
                        InformationController.selectedDietList = [];
                        for (var i = 0;
                            i < InformationController.instance.dietList.length;
                            i++) {
                          if (InformationController
                              .instance.dietList[i].isSelected) {
                            if (InformationController
                                    .instance.dietList[i].endPoint ==
                                'none') {
                              break;
                            }
                            selectCount++;
                            InformationController.selectedDietList.add(
                                InformationController
                                    .instance.dietList[i].endPoint);
                          }
                        }
                        ShowPopup().showMealGenerationPopup(
                            context: context,
                            onContinue: () async {
                              if (await InformationController.instance
                                      .updateDietary(
                                          dietList: InformationController
                                              .selectedDietList) ==
                                  false) {
                                CustomSnackBarService().showErrorSnackBar(
                                  message:
                                      "Failed to update dietary preferences",
                                );
                                return;
                              }
                              CommonController.instance.generateNewMeals();
                              CustomSnackBarService().showSuccessSnackBar(
                                message:
                                    "Dietary preferences updated successfully",
                              );
                              Navigator.pop(context);
                            });
                        return;
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
