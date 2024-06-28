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
import 'package:travsy/src/features/information/domain/models/activity_model.dart';
import 'package:travsy/src/features/information/widgets/index_viewer_widget.dart';
import 'package:travsy/src/features/information/widgets/information_screen_appbar.dart';
import 'package:travsy/src/features/information/widgets/information_selector_button.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class ActivitySelectionScreen extends StatefulWidget {
  bool isBackButtonVisible = false;
  bool isTitleEnabled = true;
  bool isAppbarTitleEnabled = false;

  ActivitySelectionScreen({
    super.key,
    this.isBackButtonVisible = false,
    this.isTitleEnabled = true,
    this.isAppbarTitleEnabled = false,
  });

  @override
  State<ActivitySelectionScreen> createState() =>
      _ActivitySelectionScreenState();
}

class _ActivitySelectionScreenState extends State<ActivitySelectionScreen> {
  int selectedMetricIndex = 120;
  int selectedImperialIndex = 1;
  bool isSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                AppLocalizations.of(context)!.activityAppbarTitle,
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
                selectedIndex: 6,
              ),
            const Gap(15),
            if (widget.isTitleEnabled)
              MultiColorTextSectionWidget(
                title1: AppLocalizations.of(context)!.activityTitle1,
                title2: AppLocalizations.of(context)!.activityTitle2,
                isTitle2Color: true,
                description: AppLocalizations.of(context)!.activityDescription,
                descriptionStyle: TextStyle(
                  color: zTextColor.withOpacity(0.5),
                  fontSize: 15,
                ),
              ),
            if (!widget.isAppbarTitleEnabled) const Gap(40),
            for (int i = 0;
                i < InformationController.instance.activityList.length;
                i++)
              InkWell(
                onTap: () {
                  setState(() {
                    if (InformationController
                            .instance.activityList[i].isSelected ==
                        false) {
                      InformationController
                          .instance.activityList[i].isSelected = true;
                    }
                    for (int j = 0;
                        j < InformationController.instance.activityList.length;
                        j++) {
                      if (j != i) {
                        InformationController
                            .instance.activityList[j].isSelected = false;
                      }
                    }
                    InformationController.selectedActivityLevel = ActivityModel(
                      title:
                          InformationController.instance.activityList[i].title,
                      endpoint: InformationController
                          .instance.activityList[i].endpoint,
                      image:
                          InformationController.instance.activityList[i].image,
                      descriptionWidget: InformationController
                          .instance.activityList[i].descriptionWidget,
                    );
                  });
                },
                child: InformationSelectorButton(
                  title: InformationController.instance.activityList[i].title,
                  image: InformationController.instance.activityList[i].image,
                  widget: InformationController
                      .instance.activityList[i].descriptionWidget,
                  isSelected:
                      InformationController.instance.activityList[i].isSelected,
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
                        if (InformationController
                                .selectedActivityLevel.endpoint ==
                            "initial") {
                          CustomSnackBarService().showWarningSnackBar(
                              message: "Please select an activity level");
                          return;
                        } else {
                          ShowPopup().showMealGenerationPopup(
                              context: context,
                              onContinue: () async {
                                if (await InformationController.instance
                                        .updateActivityLevel(
                                            level: InformationController
                                                .selectedActivityLevel
                                                .endpoint) ==
                                    false) {
                                  CustomSnackBarService().showErrorSnackBar(
                                    message: "Failed to update  activity level",
                                  );
                                  return;
                                }
                                CommonController.instance.generateNewMeals();
                                CustomSnackBarService().showSuccessSnackBar(
                                  message:
                                      "Activity level updated successfully",
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
