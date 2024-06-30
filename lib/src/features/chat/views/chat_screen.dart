import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';
import 'package:travsy/src/utils/images.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: zBackgroundColor.withOpacity(0),
          elevation: 0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
        child: ListView(
          children: [
            Container(
              height: Get.height * 0.75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(20),
                    padding: EdgeInsets.all(6),
                    color: zPrimaryColor.withOpacity(0.5),
                    strokeWidth: 1.5, // Border width
                    dashPattern: [6, 6], // Dash pattern
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.zDefaultPadding),
                        child: Column(
                          children: [
                            Image.asset(
                              zComingSoonImage,
                              height: 100,
                            ),
                            Gap(10),
                            Text(
                              "Coming Soon",
                              style: TextStyle(
                                color: zTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(20),
                            Text(
                              "Hold tight! We are working on this feature.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: zTextColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
