import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travsy/src/common/contollers/local_storage_controller.dart';
import 'package:travsy/src/common/widgets/custom_circular_progress_button.dart';
import 'package:travsy/src/features/auth/views/sign_in_screen.dart';
import 'package:travsy/src/features/onboarding/models/onboarding_model.dart';
import 'package:travsy/src/utils/app_constants.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';
import 'package:travsy/src/utils/dynamic_components.dart';
import 'package:travsy/src/utils/images.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  double progress = 0.33;
  late List<dynamic> onboardingList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onboardingList = [
      OnboardingModel(
        title: zOnboardingTitle1,
        description: zOnboardingDescription1,
        image: zOnboardingImage1,
      ),
      OnboardingModel(
        title: zOnboardingTitle2,
        description: zOnboardingDescription2,
        image: zOnboardingImage2,
      ),
      OnboardingModel(
        title: zOnboardingTitle3,
        description: zOnboardingDescription3,
        image: zOnboardingImage3,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  progress == 1
                      ? const SizedBox(
                          height: 14,
                        )
                      : TextButton(
                          onPressed: () {
                            setState(() {
                              progress = 1;
                              DynamicComponents.zCustomCircularButtonIndex = 2;
                            });
                          },
                          child: Text(
                            AppLocalizations.of(context)!.buttonSkip,
                            style: const TextStyle(
                              fontSize: Dimensions.fontSizeDefault,
                              color: zPrimaryColor,
                            ),
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.7,
                child: PageView.builder(
                  itemCount: onboardingList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          onboardingList[
                                  DynamicComponents.zCustomCircularButtonIndex]
                              .image,
                          height: 250,
                          width: 250,
                        ),
                        const Gap(60),
                        Text(
                          onboardingList[
                                  DynamicComponents.zCustomCircularButtonIndex]
                              .title,
                          style: const TextStyle(
                            fontSize: Dimensions.fontSizeLarge,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(20),
                        Text(
                          onboardingList[
                                  DynamicComponents.zCustomCircularButtonIndex]
                              .description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: Dimensions.fontSizeDefault,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 110,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomCircularProgressButton(
                progress: progress,
              ),
              InkWell(
                onTap: () async {
                  setState(
                    () {
                      if (DynamicComponents.zCustomCircularButtonIndex < 2) {
                        DynamicComponents.zCustomCircularButtonIndex++;
                        progress =
                            (DynamicComponents.zCustomCircularButtonIndex + 1) *
                                1.0 /
                                3;
                      } else {
                        Get.offAll(() => const SignInScreen());
                        LocalStorageController.instance
                            .setBool(zIsFirstTime, true);
                      }
                    },
                  );
                },
                child: Container(
                  height: 65,
                  width: 65,
                  decoration: const BoxDecoration(
                    color: zPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: progress == 1
                        ? Text(
                            AppLocalizations.of(context)!.buttonStart,
                            style: const TextStyle(
                              fontSize: Dimensions.fontSizeDefault,
                              color: zWhiteColor,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: zWhiteColor,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
