import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travsy/src/common/contollers/local_storage_controller.dart';
import 'package:travsy/src/features/profile/models/profile_model.dart';
import 'package:travsy/src/helper/api_services.dart';
import 'package:travsy/src/utils/api_urls.dart';
import 'package:travsy/src/utils/app_constants.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProfile();
  }

  ProfileModel profileModel = ProfileModel();
  static String userAge = '';
  static String userFullName = '';

  RxBool isProfileFetching = false.obs;
  fetchProfile() async {
    try {
      isProfileFetching.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: {},
        endpoint: zUserInfoEndpoint,
        isAuthToken: true,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        profileModel = ProfileModel.fromJson(decoded);
        try {
          if (profileModel.data!.dob != null) {
            var dob = profileModel.data!.dob;
            dob = DateFormat('yyyy-MM-dd').format(DateTime.parse(dob!));
            var dobSplit =
                dob?.split('-'); // Assuming dob format is "yyyy-MM-dd"
            int year = int.parse(dobSplit![0]);
            int month = int.parse(dobSplit[1]);
            int day = int.parse(dobSplit[2]);

            DateTime birthDate = DateTime(year, month, day);
            DateTime currentDate = DateTime.now();
            int age = currentDate.year - birthDate.year;
            // Adjust age if the current date is before the birthday in the current year
            if (currentDate.month < birthDate.month ||
                (currentDate.month == birthDate.month &&
                    currentDate.day < birthDate.day)) {
              age--;
            }
            userAge = age.toString();
          }
        } catch (e) {
          print("Error in calculating age: $e");
        }
        userFullName =
            '${profileModel.data!.firstName ?? ""} ${profileModel.data!.lastName ?? ""}';
        print("User Full Name is $userFullName");
        if (userFullName == " ") {
          userFullName =
              await LocalStorageController.instance.getString(zUserFullName) ??
                  "User";
          print("User Full Name is $userFullName");
        }
        isProfileFetching.value = false;
      } else {}
    } catch (e) {}
    isProfileFetching.value = false;
  }
}
