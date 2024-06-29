import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travsy/src/common/services/custom_snackbar_service.dart';
import 'package:travsy/src/helper/api_services.dart';
import 'package:travsy/src/utils/api_urls.dart';

class InfoEditingController extends GetxController {
  static InfoEditingController instance = Get.find();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController newPasswordTextController = TextEditingController();
  RxString imagePath = "".obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool isNameEditLoading = false.obs;
  RxBool isEmailEditLoading = false.obs;
  RxBool isPasswordEditLoading = false.obs;
  Future<bool> updateName(String name) async {
    isNameEditLoading.value = true;
    final response = await ApiServices.instance.getResponse(
        endpoint: zUpdateNameEndPoint, requestBody: {"name": name});
    var decode = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      isNameEditLoading.value = false;
      return true;
    } else {
      CustomSnackBarService().showErrorSnackBar(
          message: decode['message'] ?? 'Something went wrong');
      print(
          "Hello its a error------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><><>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> from name controller");
      isNameEditLoading.value = false;
    }
    isNameEditLoading.value = false;
    return false;
  }
}
