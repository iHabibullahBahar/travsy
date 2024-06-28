import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travsy/src/common/contollers/common_controller.dart';
import 'package:travsy/src/common/services/custom_snackbar_service.dart';
import 'package:travsy/src/common/services/show_popup.dart';
import 'package:travsy/src/common/widgets/custom_button.dart';
import 'package:travsy/src/common/widgets/custom_shimmer_button.dart';
import 'package:travsy/src/common/widgets/multicolor_text_section_widget.dart';
import 'package:travsy/src/features/information/controllers/information_controller.dart';
import 'package:travsy/src/features/information/widgets/birth_date_picker_widget.dart';
import 'package:travsy/src/features/information/widgets/index_viewer_widget.dart';
import 'package:travsy/src/features/information/widgets/information_screen_appbar.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class AgeInputScreen extends StatefulWidget {
  bool isBackButtonVisible = false;
  bool isTitleEnabled = true;
  bool isAppbarTitleEnabled = false;

  AgeInputScreen({
    super.key,
    this.isBackButtonVisible = false,
    this.isTitleEnabled = true,
    this.isAppbarTitleEnabled = false,
  });

  @override
  State<AgeInputScreen> createState() => _AgeInputScreenState();
}

class _AgeInputScreenState extends State<AgeInputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBackgroundColor,
      appBar: !widget.isAppbarTitleEnabled
          ? AppBarWidget(
              title: AppLocalizations.of(context)!.ageAppbarTitle,
              isTitleEnabled: widget.isAppbarTitleEnabled,
            )
          : AppBar(
              title: Text(
                AppLocalizations.of(context)!.ageAppbarTitle,
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
                selectedIndex: 3,
              ),
            const Gap(15),
            if (widget.isTitleEnabled)
              MultiColorTextSectionWidget(
                title1: AppLocalizations.of(context)!.ageTitle1,
                title2: AppLocalizations.of(context)!.ageTitle2,
                isTitle2Color: true,
                description: AppLocalizations.of(context)!.ageDescription,
                descriptionStyle: TextStyle(
                  color: zTextColor.withOpacity(0.5),
                  fontSize: 15,
                ),
              ),
            const Gap(60),
            BirthDatePickerWidget(
              isFromProfile: widget.isAppbarTitleEnabled,
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
                          ShowPopup().showMealGenerationPopup(
                            context: context,
                            onContinue: () async {
                              if (await InformationController.instance
                                      .updateAge(
                                          dob: DateFormat()
                                              .addPattern("yyyy-MM-dd")
                                              .format(InformationController
                                                  .selectedDateOfBirth!)) ==
                                  false) {
                                CustomSnackBarService().showErrorSnackBar(
                                    message: "Failed to update age");
                                return;
                              }
                              CommonController.instance.generateNewMeals();
                              CustomSnackBarService().showSuccessSnackBar(
                                message: "Age updated successfully",
                              );
                              InformationController.instance.isDateSelected =
                                  false;
                              InformationController.instance.selectedDate = "";
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
          : null,
    );
  }
}
