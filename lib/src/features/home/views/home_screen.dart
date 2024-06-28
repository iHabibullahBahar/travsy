import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travsy/src/features/home/controllers/home_controller.dart';
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
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: zBackgroundColor,
          elevation: 0,
        ),
      ),
      backgroundColor: zBackgroundColor,
      body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.zDefaultPadding,
          ),
          child: ListView(
            children: [],
          )),
    );
  }
}
