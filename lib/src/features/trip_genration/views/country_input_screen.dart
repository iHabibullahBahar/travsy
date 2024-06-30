import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travsy/src/common/widgets/custom_button.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class CountryInputScreen extends StatefulWidget {
  const CountryInputScreen({super.key});

  @override
  State<CountryInputScreen> createState() => _CountryInputScreenState();
}

class _CountryInputScreenState extends State<CountryInputScreen> {
  RxString country = "".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBackgroundColor,
      appBar: AppBar(
          backgroundColor: zBackgroundColor,
          elevation: 0,
          title: Text(
            "Destination Country",
            style: TextStyle(
              color: zTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          iconTheme: const IconThemeData(
            color: zPrimaryColor,
          )),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
        child: ListView(
          children: [
            CustomButton(
              height: 45,
              radius: 16,
              title: country.value == "" ? "Pick your country" : country.value,
              gradient: LinearGradient(colors: [
                Colors.transparent,
                Colors.transparent,
              ]),
              textStyle: TextStyle(
                color: zPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              border: Border.all(
                color: zPrimaryColor,
                width: 1,
              ),
              onPressed: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode:
                      true, // optional. Shows phone code before the country name.
                  onSelect: (Country country) {
                    this.country.value = country.name!;

                    setState(() {});
                    print('Select country: ${country.displayName}');
                  },
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(Dimensions.zDefaultPadding),
        child: CustomButton(
          height: 55,
          radius: 16,
          title: "Next",
          onPressed: () {},
        ),
      ),
    );
  }
}
