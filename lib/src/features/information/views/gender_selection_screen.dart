import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:travsy/src/common/widgets/multicolor_text_section_widget.dart';
import 'package:travsy/src/features/information/controllers/information_controller.dart';
import 'package:travsy/src/features/information/widgets/gender_widget.dart';
import 'package:travsy/src/features/information/widgets/index_viewer_widget.dart';
import 'package:travsy/src/features/information/widgets/information_screen_appbar.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';
import 'package:travsy/src/utils/images.dart';

class GenderSelectionScreen extends StatefulWidget {
  bool isBackButtonVisible = false;
  bool isTitleEnabled = true;
  bool isAppbarTitleEnabled = false;

  GenderSelectionScreen({
    super.key,
    this.isBackButtonVisible = false,
    this.isTitleEnabled = true,
    this.isAppbarTitleEnabled = false,
  });

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBackgroundColor,
      appBar: AppBarWidget(
        title: "Gender Selection",
        isTitleEnabled: widget.isAppbarTitleEnabled,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeExtraLarge),
        child: ListView(
          children: [
            if (widget.isTitleEnabled)
              IndexViewWidget(
                selectedIndex: 2,
              ),
            const Gap(15),
            if (widget.isTitleEnabled)
              MultiColorTextSectionWidget(
                title1: AppLocalizations.of(context)!.genderTitle1,
                title2: AppLocalizations.of(context)!.genderTitle2,
                isTitle2Color: true,
                description: AppLocalizations.of(context)!.genderDescription,
                descriptionStyle: TextStyle(
                  color: zTextColor.withOpacity(0.5),
                  fontSize: 15,
                ),
              ),
            const Gap(60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                      InformationController.selectedGender = "male";
                    });
                  },
                  child: GenderWidget(
                    title: AppLocalizations.of(context)!.male,
                    image: zMaleImage,
                    isSelected: selectedIndex == 0,
                  ),
                ),
                const Gap(20),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                      InformationController.selectedGender = "female";
                    });
                  },
                  child: GenderWidget(
                    title: AppLocalizations.of(context)!.female,
                    image: zFemaleImage,
                    isSelected: selectedIndex == 1,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
