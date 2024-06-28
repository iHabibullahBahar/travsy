import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travsy/src/common/contollers/local_storage_controller.dart';
import 'package:travsy/src/features/auth/controllers/auth_controller.dart';
import 'package:travsy/src/features/information/controllers/information_controller.dart';
import 'package:travsy/src/features/information/views/activity_level_selection_screen.dart';
import 'package:travsy/src/features/information/views/dietary_selection-screen.dart';
import 'package:travsy/src/features/information/views/goal_selector_screen.dart';
import 'package:travsy/src/features/information/views/meal_structure_selection_screen.dart';
import 'package:travsy/src/features/profile/controllers/profile_controller.dart';
import 'package:travsy/src/features/profile/widgets/profile_rectangle_button.dart';
import 'package:travsy/src/features/profile/widgets/profile_summery_widget.dart';
import 'package:travsy/src/features/subscription/views/subscription_screen.dart';
import 'package:travsy/src/utils/app_constants.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';
import 'package:travsy/src/utils/images.dart';

import '../widgets/profile_edit_button.dart';
import 'profile_info_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: zBackgroundColor,
          elevation: 0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
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
                  children: [
                    Gap(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProfileSummeryWidget(),
                      ],
                    ),
                    Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileRectangleButton(
                          title: AppLocalizations.of(context)!.profile,
                          icon: zProfileGradientIcon,
                          onPressed: () {
                            Get.to(
                              () => ProfileInfoScreen(),
                            );
                          },
                          isBackgroundColor: true,
                        ),
                        ProfileRectangleButton(
                          title: AppLocalizations.of(context)!.subscription,
                          icon: zSubscriptionIcon,
                          onPressed: () async {
                            var authToken = await LocalStorageController
                                .instance
                                .getString(zAuthToken);
                            Get.to(SubscriptionScreen(
                              isBackButtonVisible: true,
                            ));
                          },
                          isBackgroundColor: false,
                        ),
                      ],
                    ),
                    Gap(20),
                    ProfileEditButton(
                      title: AppLocalizations.of(context)!.dietaryRequirements,
                      icon: zProfileIcon1,
                      onPressed: () {
                        if (ProfileController.instance.profileModel.data!
                            .dietaryOptions!.isEmpty) {
                          InformationController.instance.setDietList(0);
                          InformationController
                              .instance.dietList[0].isSelected = true;
                        } else {
                          ///These lines of code are used to set the selected dietary requirements
                          for (int i = 0;
                              i <
                                  InformationController
                                      .instance.dietList.length;
                              i++) {
                            if (ProfileController
                                .instance.profileModel.data!.dietaryOptions!
                                .contains(InformationController
                                    .instance.dietList[i].endPoint)) {
                              InformationController
                                  .instance.dietList[i].isSelected = true;
                            } else {
                              InformationController
                                  .instance.dietList[i].isSelected = false;
                            }
                          }
                        }

                        Get.to(
                          () => DietarySelectionScreen(
                            isTitleEnabled: false,
                            isBackButtonVisible: true,
                            isAppbarTitleEnabled: true,
                          ),
                        );
                      },
                      isValueRequired: false,
                    ),
                    ProfileEditButton(
                      title: AppLocalizations.of(context)!.mealStructure,
                      icon: zProfileIcon2,
                      onPressed: () {
                        ///These lines of code are used to set the selected meal structure
                        int selectedIndex = InformationController.instance
                            .getSelectedMealIndex();
                        InformationController.selectedMealStructure =
                            InformationController
                                .instance.mealList[selectedIndex];
                        InformationController
                            .instance.mealList[selectedIndex].isSelected = true;
                        for (int i = 0;
                            i < InformationController.instance.mealList.length;
                            i++) {
                          if (i != selectedIndex) {
                            InformationController
                                .instance.mealList[i].isSelected = false;
                          }
                        }

                        ///It will navigate to the meal structure selection screen
                        Get.to(
                          () => MealStructureSelectionScreen(
                            isTitleEnabled: false,
                            isBackButtonVisible: true,
                            isAppbarTitleEnabled: true,
                          ),
                        );
                      },
                      isValueRequired: false,
                    ),
                    ProfileEditButton(
                      title: AppLocalizations.of(context)!.setYourGoal,
                      icon: zProfileIcon3,
                      onPressed: () {
                        ///These lines of code are used to set the selected goal
                        int index = InformationController.instance
                            .getSelectedGoalIndex();
                        InformationController.selectedGoal =
                            InformationController
                                .instance.goalList[index].endpoint;
                        InformationController
                            .instance.goalList[index].isSelected = true;
                        for (int i = 0;
                            i < InformationController.instance.goalList.length;
                            i++) {
                          if (i != index) {
                            InformationController
                                .instance.goalList[i].isSelected = false;
                          }
                        }
                        Get.to(
                          () => GoalSelectionScreen(
                            isTitleEnabled: false,
                            isBackButtonVisible: true,
                            isAppbarTitleEnabled: true,
                          ),
                        );
                      },
                      isValueRequired: false,
                    ),
                    ProfileEditButton(
                      title: AppLocalizations.of(context)!.setYourActivityLevel,
                      icon: zProfileIcon3,
                      onPressed: () {
                        ///These lines of code are used to set the selected goal
                        int index = InformationController.instance
                            .getSelectedActivityIndex();
                        InformationController.selectedActivityLevel =
                            InformationController.instance.activityList[index];
                        InformationController
                            .instance.activityList[index].isSelected = true;
                        for (int i = 0;
                            i <
                                InformationController
                                    .instance.activityList.length;
                            i++) {
                          if (i != index) {
                            InformationController
                                .instance.activityList[i].isSelected = false;
                          }
                        }
                        Get.to(
                          () => ActivitySelectionScreen(
                            isTitleEnabled: false,
                            isBackButtonVisible: true,
                            isAppbarTitleEnabled: true,
                          ),
                        );
                      },
                      isValueRequired: false,
                    ),
                    Gap(20),
                    InkWell(
                      onTap: () async {
                        await AuthController.instance.signOut();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.buttonLogout,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: zPrimaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
            Gap(20),
          ],
        ),
      ),
    );
  }
}
