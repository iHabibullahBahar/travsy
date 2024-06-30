import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travsy/src/features/home/controllers/home_controller.dart';
import 'package:travsy/src/features/home/widgets/trip_widget.dart';
import 'package:travsy/src/features/notification/views/notification_screen.dart';
import 'package:travsy/src/features/trip_genration/views/country_input_screen.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: zBackgroundColor,
          elevation: 0,
          flexibleSpace: SafeArea(
            minimum: EdgeInsets.only(
              top: Dimensions.zDefaultPadding,
              left: Dimensions.zDefaultPadding,
              right: Dimensions.zDefaultPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => NotificationScreen());
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: zGraySwatch[300],
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      Icons.notifications,
                      color: zWhiteColor,
                    ),
                  ),
                ),
                Text(
                  "Trips",
                  style: TextStyle(
                    color: zTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                InkWell(
                  onTap: () {
                    ///TODO: Add new trip  functionality will be added here
                    Get.to(() => CountryInputScreen());
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: zPrimaryColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      Icons.add,
                      color: zWhiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: zBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.zDefaultPadding,
        ),
        child: ListView(
          children: [
            for (int i = 0; i < 10; i++) TripWidget(),
            // Container(
            //   height: Get.height * 0.60,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       HomeEmptyWidget(),
            //     ],
            //   ),
            // )
          ],
        ),
      ),

      // bottomNavigationBar: Container(
      //   color: Colors.transparent,
      //   child: Row(
      //     children: [
      //       Container(
      //         height: 50,
      //         width: 50,
      //         decoration: BoxDecoration(
      //           color: zPrimaryColor,
      //           borderRadius: BorderRadius.circular(100),
      //         ),
      //         child: Icon(
      //           Icons.add,
      //           color: zPrimaryColor,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
