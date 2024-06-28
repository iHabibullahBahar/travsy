import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travsy/src/common/contollers/common_controller.dart';
import 'package:travsy/src/common/services/custom_snackbar_service.dart';
import 'package:travsy/src/common/widgets/custom_button.dart';
import 'package:travsy/src/common/widgets/custom_shimmer_button.dart';
import 'package:travsy/src/common/widgets/multicolor_text_section_widget.dart';
import 'package:travsy/src/features/information/controllers/information_controller.dart';
import 'package:travsy/src/features/information/widgets/height_widget.dart';
import 'package:travsy/src/features/information/widgets/index_viewer_widget.dart';
import 'package:travsy/src/features/information/widgets/information_screen_appbar.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class HeightInputScreen extends StatefulWidget {
  bool isTitleEnabled = true;
  bool isBackButtonVisible = false;
  bool isAppbarTitleEnabled = false;

  HeightInputScreen({
    super.key,
    this.isTitleEnabled = true,
    this.isAppbarTitleEnabled = false,
    this.isBackButtonVisible = false,
  });

  @override
  State<HeightInputScreen> createState() => _HeightInputScreenState();
}

class _HeightInputScreenState extends State<HeightInputScreen> {
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
              title: AppLocalizations.of(context)!.heightAppbarTitle,
              isTitleEnabled: widget.isAppbarTitleEnabled,
            )
          : AppBar(
              title: Text(
                AppLocalizations.of(context)!.heightAppbarTitle,
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
                selectedIndex: 4,
              ),
            const Gap(15),
            if (widget.isTitleEnabled)
              MultiColorTextSectionWidget(
                title1: AppLocalizations.of(context)!.tallTitle1,
                title2: AppLocalizations.of(context)!.tallTitle2,
                title3: AppLocalizations.of(context)!.tallTitle3,
                isTitle2Color: true,
                description: AppLocalizations.of(context)!.tallDescription,
                descriptionStyle: TextStyle(
                  color: zTextColor.withOpacity(0.5),
                  fontSize: 15,
                ),
              ),
            HeightWidget(),
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
                        CommonController.instance.generateNewMeals();
                        CustomSnackBarService().showSuccessSnackBar(
                            message: "Height updated successfully");
                        Navigator.pop(context);
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
