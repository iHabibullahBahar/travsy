import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travsy/src/features/notification/controllers/notification_controller.dart';
import 'package:travsy/src/features/notification/widgets/notification_widget.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Get.put(NotificationController());
    // NotificationController.instance.fetchNotification(isRefresh: true);
    // scrollController.addListener(() {
    //   if (scrollController.position.maxScrollExtent ==
    //       scrollController.offset) {
    //     NotificationController.instance.isNotificationFetching.value == false
    //         ? NotificationController.instance
    //             .fetchNotification(isRefresh: false)
    //         : null;
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBackgroundColor,
      appBar: AppBar(
        title: const Text(
          "Notification",
          style: TextStyle(
            color: zTextColor,
            fontStyle: FontStyle.italic,
            fontSize: Dimensions.zAppBarTitleFontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconTheme: const IconThemeData(
          color: zPrimaryColor,
        ),
        backgroundColor: zBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
        child: ListView(
          controller: scrollController,
          children: [
            for (int i = 0; i < 10; i++)
              NotificationWidget(
                title: "You are becoming popular",
                description: "Hey, your trip plan reached 100 likes.",
                time: "45 min ago",
              ),
            // Obx(() {
            //   if (NotificationController
            //       .instance.isNotificationFetching.value) {
            //     return Container(
            //       height: Get.height * 0.7,
            //       child: const Center(
            //         child: CircularProgressIndicator(
            //           color: zPrimaryColor,
            //         ),
            //       ),
            //     );
            //   } else if (NotificationController
            //           .instance.notificationModel.data!.notifications! ==
            //       []) {
            //     return Container(
            //       height: Get.height * 0.7,
            //       child: const Center(
            //         child: Text("No Notification Found"),
            //       ),
            //     );
            //   } else {
            //     return Column(
            //       children: [
            //         // for (var notification in NotificationController
            //         //     .instance.notificationModel.data!.notifications!)
            //         NotificationWidget(
            //           title: "You are becoming popular",
            //           description: "Hey, your trip plan reached 100 likes.",
            //           time: "45 min ago",
            //         ),
            //         // Obx(() {
            //         //   if (NotificationController
            //         //           .instance.isMoreNotificationLoading.value ==
            //         //       true) {
            //         //     return Column(
            //         //       children: [
            //         //         Gap(10),
            //         //         const Center(
            //         //           child: CircularProgressIndicator(
            //         //             color: zPrimaryColor,
            //         //           ),
            //         //         ),
            //         //         const SizedBox(height: 20),
            //         //       ],
            //         //     );
            //         //   } else {
            //         //     return const SizedBox();
            //         //   }
            //         // })
            //       ],
            //     );
            //   }
            // }),
            // Gap(Dimensions.zDefaultPadding * 2),
          ],
        ),
      ),
    );
  }
  //dispose

  @override
  void dispose() {
    super.dispose();
  }
}
