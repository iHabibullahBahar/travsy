import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:travsy/src/features/information/controllers/information_controller.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class BirthDatePickerWidget extends StatefulWidget {
  bool isFromProfile = false;
  BirthDatePickerWidget({Key? key, this.isFromProfile = false})
      : super(key: key);

  @override
  State<BirthDatePickerWidget> createState() => _BirthDatePickerWidgetState();
}

class _BirthDatePickerWidgetState extends State<BirthDatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        InformationController.selectedDateOfBirth = await showDatePicker(
          context: context,
          initialDate: widget.isFromProfile
              ? InformationController.initialDateOfBirth!
              : DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: zPrimaryColor,
                  onPrimary: Colors.white,
                ),
                dividerTheme: const DividerThemeData(
                  color: zPrimaryColor,
                  thickness: 0.2,
                  indent: 0,
                ),
                iconButtonTheme: const IconButtonThemeData(
                  style: ButtonStyle(
                    iconColor: MaterialStatePropertyAll(zPrimaryColor),
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
        setState(() {
          //Show only the date
          DateFormat dateFormat =
              DateFormat('dd MMMM yyyy'); // You can use any format you want
          InformationController.instance.selectedDate =
              dateFormat.format(InformationController.selectedDateOfBirth!);
          InformationController.instance.isDateSelected = true;
          if (InformationController.selectedDateOfBirth != null) {
            InformationController.initialDateOfBirth =
                InformationController.selectedDateOfBirth;
          }
        });
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.zButtonRadiusLarge),
          border: Border.all(
            color: zPrimaryColor,
            width: 0.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            Dimensions.zDefaultPadding,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                InformationController.instance.isDateSelected
                    ? InformationController.instance.selectedDate
                    : AppLocalizations.of(context)!.pickYourBirthday,
                style: const TextStyle(
                  color: zPrimaryColor,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              //CupertinoIcon
              const Icon(
                Icons.calendar_month,
                color: zPrimaryColor,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
