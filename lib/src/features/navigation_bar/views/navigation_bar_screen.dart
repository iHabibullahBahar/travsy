import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travsy/src/common/contollers/common_controller.dart';
import 'package:travsy/src/features/auth/controllers/auth_controller.dart';
import 'package:travsy/src/features/chat/views/chat_screen.dart';
import 'package:travsy/src/features/home/controllers/home_controller.dart';
import 'package:travsy/src/features/home/views/home_screen.dart';
import 'package:travsy/src/features/profile/controllers/profile_controller.dart';
import 'package:travsy/src/features/profile/views/profile_screen.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';
import 'package:travsy/src/utils/images.dart';

class NavigationBarScreen extends StatefulWidget {
  NavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  List<dynamic> selectedIcons = [zHomeIcon, zFeedIcon, zChatIcon, zProfileIcon];

  @override
  void initState() {
    super.initState();
    Get.put(CommonController());
    //Get.put(ProfileController());
    Get.put(HomeController());
    Get.put(ProfileController());

    //Get.put(InformationController());
    Get.lazyPut(() => AuthController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: zGraySwatch[50],
      body: Obx(() {
        return IndexedStack(
          index: CommonController.instance.selectedNavigationIndex.value,
          children: [
            HomeScreen(),
            HomeScreen(),
            ChatScreen(),
            ProfileScreen(),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        if (CommonController.instance.selectedNavigationIndex.value == 5) {
          return Container();
        } else {
          return SafeArea(
            minimum: EdgeInsets.only(
              bottom: Dimensions.zDefaultPadding,
              right: Dimensions.zDefaultPadding,
              left: Dimensions.zDefaultPadding,
            ),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                // gradient: zPrimaryGradientLeftToRight,
                color: zWhiteColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  selectedIcons.length,
                  (index) => InkWell(
                    highlightColor: Colors.transparent,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () async {
                      setState(() {});
                      if (index ==
                          CommonController
                              .instance.selectedNavigationIndex.value) return;

                      CommonController.instance.selectedNavigationIndex.value =
                          index;

                      if (index == 0) {
                      } else if (index == 1) {
                      } else if (index == 2) {
                      } else if (index == 3) {
                        ProfileController.instance.fetchProfile();
                      }
                    },
                    child: Container(
                      width: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            selectedIcons[index],
                            height: 30,
                            color: zPrimaryColor,
                          ),
                          const Gap(15),
                          if (CommonController
                                  .instance.selectedNavigationIndex.value ==
                              index)
                            Image.asset(
                              zNavigationHorizontalBar,
                              height: 5,
                              color: zPrimaryColor,
                            ),
                          if (CommonController
                                  .instance.selectedNavigationIndex.value !=
                              index)
                            const Gap(5),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
