import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travsy/src/features/information/controllers/information_controller.dart';
import 'package:travsy/src/features/information/views/age_input_screen.dart';
import 'package:travsy/src/features/information/views/height_input_screen.dart';
import 'package:travsy/src/features/information/views/weight_input_screen.dart';
import 'package:travsy/src/features/profile/controllers/profile_controller.dart';
import 'package:travsy/src/features/profile/views/profile_image_edit_screen.dart';
import 'package:travsy/src/features/profile/widgets/profile_edit_button.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';
import 'package:travsy/src/utils/images.dart';

class ProfileInfoScreen extends StatelessWidget {
  const ProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBackgroundColor,
      appBar: AppBar(
        backgroundColor: zBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: zPrimaryColor,
        ),
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: const TextStyle(
            color: zTextColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.zDefaultPadding,
          vertical: 10,
        ),
        child: ListView(
          children: [
            Obx(() {
              if (ProfileController.instance.isProfileFetching.value) {
                return const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        color: zPrimaryColor,
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: zPrimaryColor.withOpacity(0.35),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.zDefaultPadding),
                        child: Row(
                          children: [
                            SizedBox(
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: zPrimaryColor.withOpacity(0.35),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: FancyShimmerImage(
                                    ///TODO: Change the image URL to the user's profile image from the api
                                    imageUrl: ProfileController.instance
                                            .profileModel.data!.image ??
                                        '',
                                    boxFit: BoxFit.cover,
                                    height: 45,
                                    width: 45,
                                    errorWidget: Icon(
                                      Icons.person,
                                      color: zPrimaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(15),
                            Container(
                              width: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ProfileController.userFullName,
                                    style: TextStyle(
                                      color: zTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Text(
                                    ProfileController
                                        .instance.profileModel.data!.email!,
                                    style: TextStyle(
                                      color: zTextColor.withOpacity(0.75),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Get.to(() => ProfileImageEditScreen());
                              },
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  gradient: zPrimaryGradientTopToBottom,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: zWhiteColor,
                                  size: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(25),
                    Text(
                      AppLocalizations.of(context)!.yourInformation,
                      style: TextStyle(
                        color: zTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const Gap(20),
                    ProfileEditButton(
                      title: AppLocalizations.of(context)!.age,
                      icon: zProfileIcon4,
                      onPressed: () {
                        InformationController.instance.isDateSelected = true;
                        try {
                          String isoDate = ProfileController
                              .instance.profileModel.data!.dob!;
                          DateTime parsedDate = DateTime.parse(isoDate);
                          InformationController.initialDateOfBirth = parsedDate;
                          String formattedDate =
                              DateFormat('dd MMMM yyyy').format(parsedDate);
                          InformationController.instance.selectedDate =
                              formattedDate;
                          Get.to(
                            () => AgeInputScreen(
                              isTitleEnabled: false,
                              isBackButtonVisible: true,
                              isAppbarTitleEnabled: true,
                            ),
                          );
                        } catch (e) {
                          print(e);
                        }
                      },
                      value: ProfileController.userAge,
                      unit: " Yo",
                      isValueRequired: true,
                    ),
                    ProfileEditButton(
                      title: AppLocalizations.of(context)!.weight,
                      icon: zProfileIcon5,
                      onPressed: () {
                        Get.to(
                          () => WeightInputScreen(
                            isTitleEnabled: false,
                            isBackButtonVisible: true,
                            isAppbarTitleEnabled: true,
                          ),
                        );
                      },
                      value: (ProfileController
                              .instance.profileModel.data!.weight!
                              .toInt())
                          .toString(),
                      unit: " kg",
                      isValueRequired: true,
                    ),
                    ProfileEditButton(
                      title: AppLocalizations.of(context)!.height,
                      icon: zProfileIcon6,
                      onPressed: () {
                        Get.to(
                          () => HeightInputScreen(
                            isTitleEnabled: false,
                            isBackButtonVisible: true,
                            isAppbarTitleEnabled: true,
                          ),
                        );
                      },
                      value: (ProfileController
                              .instance.profileModel.data!.height!
                              .toInt())
                          .toString(),
                      unit: " cm",
                      isValueRequired: true,
                    ),
                    // ProfileEditButton(
                    //   title: AppLocalizations.of(context)!.name,
                    //   icon: zProfileIcon7,
                    //   onPressed: () {},
                    //   value: ProfileController.instance.profileModel.data!.firstName!,
                    //   unit:
                    //       " ${ProfileController.instance.profileModel.data!.lastName!}",
                    //   isValueRequired: true,
                    // ),
                    Gap(20),
                    if (ProfileController
                            .instance.profileModel.data!.referral !=
                        "null")
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.referralCode,
                            style: TextStyle(
                              color: zTextColor.withOpacity(0.5),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            ProfileController
                                .instance.profileModel.data!.referral!,
                            style: TextStyle(
                              color: zTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      )
                  ],
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
