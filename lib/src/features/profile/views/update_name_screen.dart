import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travsy/src/common/widgets/custom_button_with_icon.dart';
import 'package:travsy/src/common/widgets/custom_input_field.dart';
import 'package:travsy/src/common/widgets/custom_shimmer_button.dart';
import 'package:travsy/src/features/profile/controllers/info_editing_controller.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class UpdateNameScreen extends StatelessWidget {
  const UpdateNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBackgroundColor,
      appBar: AppBar(
          title: const Text(
            'Edit Name',
            style: TextStyle(
              color: zTextColor,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          backgroundColor: zBackgroundColor.withOpacity(0),
          elevation: 0,
          iconTheme: const IconThemeData(
            color: zTextColor,
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
          child: ListView(
            children: [
              Text(
                'Full Name',
                style: TextStyle(
                  color: zTextColor.withOpacity(0.8),
                ),
              ),
              Gap(10),
              CustomInputField(
                controller: InfoEditingController.instance.nameController,
                hintText: 'Enter your name',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(
          bottom: Dimensions.zDefaultPadding,
          left: Dimensions.zDefaultPadding,
          right: Dimensions.zDefaultPadding,
        ),
        child: Obx(
          () {
            if (InfoEditingController.instance.isNameEditLoading.value) {
              return CustomShimmerButton();
            } else {
              return CustomButtonWithIcon(
                title: "Update",
                onPressed: () async {
                  if (InfoEditingController
                      .instance.nameController.text.isEmpty) {
                    Get.snackbar('Error', 'Name cannot be empty',
                        backgroundColor: zErrorSwatch,
                        colorText: zWhiteColor,
                        snackPosition: SnackPosition.BOTTOM);
                    return;
                  }
                  if (await InfoEditingController.instance.updateName(
                      InfoEditingController.instance.nameController.text)) {
                    InfoEditingController.instance.nameController.clear();
                    Get.back();
                  }
                },
                icon: Icons.arrow_forward_ios,
              );
            }
          },
        ),
      ),
    );
  }
}
