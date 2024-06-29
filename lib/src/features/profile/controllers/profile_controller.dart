import 'dart:convert';

import 'package:get/get.dart';
import 'package:travsy/src/features/profile/models/profile_model.dart';
import 'package:travsy/src/helper/api_services.dart';
import 'package:travsy/src/utils/api_urls.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  ProfileModel profileModel = ProfileModel();
  static String userAge = '';
  static String userFullName = '';

  RxBool isProfileFetching = false.obs;
  fetchProfile() async {
    try {
      isProfileFetching.value = true;
      // var response = await ApiServices.instance.getResponse(
      //   requestBody: {},
      //   endpoint: zUserInfoEndpoint,
      //   isAuthToken: true,
      // );
      // var decoded = jsonDecode(response.body);
    } catch (e) {}
    isProfileFetching.value = false;
  }
}
