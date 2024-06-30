import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travsy/src/common/widgets/custom_button.dart';
import 'package:travsy/src/utils/dimensions.dart';

class HomeEmptyWidget extends StatelessWidget {
  const HomeEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "Welcome",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(15),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.zDefaultPadding,
            ),
            child: Text(
              "We are excited to help you plan your dream vacations and unforgettable adventures. Once you create your first travel plan, it will appear here for easy access and organization.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Gap(50),
          Container(
            width: 200,
            child: CustomButton(
              height: 40,
              radius: 12,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              title: "Create Your First Trip",
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
