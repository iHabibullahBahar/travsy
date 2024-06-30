import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travsy/src/features/profile/controllers/info_editing_controller.dart';
import 'package:travsy/src/features/profile/controllers/profile_controller.dart';
import 'package:travsy/src/features/profile/controllers/profile_image_update_controller.dart';
import 'package:travsy/src/features/profile/views/profile_image_edit_screen.dart';
import 'package:travsy/src/features/profile/widgets/profile_edit_section.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class ProfileEditScreen extends StatefulWidget {
  ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  InfoEditingController infoEditingController =
      Get.put(InfoEditingController());
  ProfilePictureUploadController profilePictureUploadController =
      Get.put(ProfilePictureUploadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBackgroundColor,
      appBar: AppBar(
        backgroundColor: zBackgroundColor,
        elevation: 0,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: zTextColor,
          ),
        ),
        iconTheme: const IconThemeData(
          color: zPrimaryColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
        child: ListView(
          children: <Widget>[
            // Obx(() {
            //   if (ProfileController.instance.isProfileFetching.value == false) {
            //     return const Center(
            //       child: CircularProgressIndicator(
            //         color: zPrimaryColor,
            //       ),
            //     );
            //   }
            //   return ;
            // }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 130,
                      width: 130,
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: zPrimaryColor,
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Obx(() {
                                if (ProfileController
                                        .instance.isProfileFetching.value ==
                                    false) {
                                  return Icon(
                                    Icons.person,
                                    size: 60,
                                    color: zWhiteColor,
                                  );
                                } else {
                                  return FancyShimmerImage(
                                    imageUrl: ProfileController.instance
                                        .profileModel.data!.user!.photo!,
                                    boxFit: BoxFit.cover,
                                    height: 120,
                                    width: 120,
                                    errorWidget: Container(
                                      color: zGraySwatch[50],
                                      child: Icon(
                                        Icons.error,
                                        color: zGraySwatch[50],
                                      ),
                                    ),
                                  );
                                }
                              }),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: InkWell(
                        onTap: () {
                          Get.to(() => ProfileImageEditScreen());
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: zGraySwatch,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: zWhiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Gap(20),
            ProfileEditSection(),
          ],
        ),
      ),
    );
  }
}
