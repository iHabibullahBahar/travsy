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
import 'package:travsy/src/features/information/widgets/weight_widget.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class WeightInputScreen extends StatefulWidget {
  bool isBackButtonVisible = false;
  bool isTitleEnabled = true;
  bool isAppbarTitleEnabled = false;

  WeightInputScreen({
    super.key,
    this.isBackButtonVisible = false,
    this.isTitleEnabled = true,
    this.isAppbarTitleEnabled = false,
  });

  @override
  State<WeightInputScreen> createState() => _WeightInputScreenState();
}

class _WeightInputScreenState extends State<WeightInputScreen> {
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
              title: AppLocalizations.of(context)!.weightAppbarTitle,
              isTitleEnabled: widget.isAppbarTitleEnabled,
            )
          : AppBar(
              title: Text(
                AppLocalizations.of(context)!.weightAppbarTitle,
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
                selectedIndex: 5,
              ),
            const Gap(15),
            if (widget.isTitleEnabled)
              MultiColorTextSectionWidget(
                title1: AppLocalizations.of(context)!.weightTitle1,
                title2: AppLocalizations.of(context)!.weightTitle2,
                isTitle2Color: true,
                description: AppLocalizations.of(context)!.weightDescription,
                descriptionStyle: TextStyle(
                  color: zTextColor.withOpacity(0.5),
                  fontSize: 15,
                ),
              ),
            WeightWidget(),
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
                        int weight = InformationController.selectedWeight;
                        if (InformationController.selectedUnit!.value ==
                            "imperial") {
                          weight =
                              (InformationController.selectedWeight * 0.453592)
                                  .toInt();
                        }

                        ShowPopup().showMealGenerationPopup(
                            context: context,
                            onContinue: () async {
                              if (await InformationController.instance
                                      .updateWeight(weight: weight) ==
                                  false) {
                                CustomSnackBarService().showErrorSnackBar(
                                  message: "Failed to update weight",
                                );
                                return;
                              }
                              CommonController.instance.generateNewMeals();
                              CustomSnackBarService().showSuccessSnackBar(
                                message: "Weight updated successfully",
                              );
                              Navigator.pop(context);
                            });
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
