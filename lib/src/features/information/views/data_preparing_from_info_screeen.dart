import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:travsy/src/features/auth/controllers/auth_controller.dart';
import 'package:travsy/src/features/information/controllers/information_controller.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/images.dart';

class DataPreparingFromInfo extends StatefulWidget {
  const DataPreparingFromInfo({super.key});

  @override
  State<DataPreparingFromInfo> createState() => _DataPreparingFromInfoState();
}

class _DataPreparingFromInfoState extends State<DataPreparingFromInfo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///Remove the screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      InformationController.instance.clearData();
      AuthController.instance.validateUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Gap(150),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 180,
                    width: 180,
                    child: LoadingIndicator(
                      indicatorType: Indicator.circleStrokeSpin,
                      colors: const [zPrimaryColor],
                      strokeWidth: 4,
                      pathBackgroundColor: zPrimaryColor.withOpacity(0.5),
                    ),
                  ),
                  Container(
                    height: 135,
                    width: 135,
                    decoration: BoxDecoration(
                      gradient: zPrimaryGradientTopToBottom,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Image.asset(
                        zInfoPrepareImage,
                        height: 85,
                        width: 85,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gap(70),
          Text(
            AppLocalizations.of(context)!.dataPreparingTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: zTextColor,
                fontStyle: FontStyle.italic),
          ),
          const Gap(10),
          Text(
            AppLocalizations.of(context)!.dataPreparingDescription,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: zTextColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
