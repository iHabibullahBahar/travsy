import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travsy/src/common/widgets/custom_button_with_icon.dart';
import 'package:travsy/src/common/widgets/custom_input_field.dart';
import 'package:travsy/src/features/auth/controllers/auth_controller.dart';
import 'package:travsy/src/features/auth/widgets/auth_header_widget.dart';
import 'package:travsy/src/helper/data_validator.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class ForgotPasswordEmailInputScreen extends StatefulWidget {
  @override
  State<ForgotPasswordEmailInputScreen> createState() =>
      _ForgotPasswordEmailInputScreenState();
}

class _ForgotPasswordEmailInputScreenState
    extends State<ForgotPasswordEmailInputScreen> {
  AuthController authController = Get.put(AuthController());

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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
          child: ListView(
            children: [
              Gap(50),
              AuthHeaderWidget(
                title: AppLocalizations.of(context)!.forgotPasswordTitle,
                description:
                    AppLocalizations.of(context)!.forgotPasswordDescription,
              ),
              Gap(50),
              CustomInputField(
                hintText: AppLocalizations.of(context)!.email,
                controller: authController.emailController,
                icon: CupertinoIcons.mail_solid,
                isIconRequired: true,
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
        child: CustomButtonWithIcon(
          title: AppLocalizations.of(context)!.buttonResetPassword,
          onPressed: () async {
            if (DataValidator.validateEmail(
                authController.emailController.text)) {
              if (await authController.forgotPassword(
                  email: authController.emailController.text)) {
                Navigator.of(context).pop();
              }
            } else {
              Get.snackbar(
                "Error",
                AppLocalizations.of(context)!.invalidEmail,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: zErrorSwatch,
                duration: const Duration(seconds: 2),
                colorText: zWhiteColor,
              );
            }
          },
          icon: Icons.arrow_forward_ios,
        ),
      ),
    );
  }
}
