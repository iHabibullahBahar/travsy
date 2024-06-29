import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travsy/src/features/auth/controllers/auth_controller.dart';
import 'package:travsy/src/features/auth/widgets/auth_header_widget.dart';
import 'package:travsy/src/features/auth/widgets/social_buttons_section_widget.dart';
import 'package:travsy/src/utils/app_constants.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';
import 'package:travsy/src/utils/images.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBlackColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: zBlackColor,
          elevation: 0,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
          child: ListView(
            children: [
              Gap(50),
              Image.asset(
                zAppLogo,
                height: 150,
              ),
              Text(
                zAppName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: zWhiteColor,
                ),
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
        child: Container(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AuthHeaderWidget(
                title: AppLocalizations.of(context)!.loginTitle,
                description: AppLocalizations.of(context)!.loginDescription,
              ),
              Gap(10),
              SocialButtonSectionWidget(),
              Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  legalButton(
                    onPresed: () {},
                    title: "Terms",
                  ),
                  Text(
                    "  |  ",
                    style: TextStyle(
                      fontSize: 18,
                      color: zGraySwatch[500],
                    ),
                  ),
                  legalButton(
                    onPresed: () {
                      print("Privacy");
                    },
                    title: "Privacy",
                  ),
                ],
              ),
              Gap(10),
            ],
          ),
        ),
      ),
    );
  }

  Widget legalButton({required onPresed, required title}) {
    return InkWell(
      onTap: onPresed,
      child: Text(
        title,
        style: TextStyle(
          color: zGraySwatch[500],
          fontSize: 14,
        ),
      ),
    );
  }
}
