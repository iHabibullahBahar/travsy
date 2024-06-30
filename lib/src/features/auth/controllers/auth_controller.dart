import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:travsy/global.dart';
import 'package:travsy/src/common/contollers/common_controller.dart';
import 'package:travsy/src/common/contollers/local_storage_controller.dart';
import 'package:travsy/src/common/services/custom_snackbar_service.dart';
import 'package:travsy/src/features/auth/views/sign_in_screen.dart';
import 'package:travsy/src/features/navigation_bar/views/navigation_bar_screen.dart';
import 'package:travsy/src/helper/api_services.dart';
import 'package:travsy/src/helper/token_maker.dart';
import 'package:travsy/src/utils/api_urls.dart';
import 'package:travsy/src/utils/app_constants.dart';
import 'package:travsy/src/utils/colors.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  static RxBool isWritingComplete = true.obs;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  RxBool isTermsAndConditionsAccepted = false.obs;

  ///Sign Up With Email and Password
  RxBool isSignUpLoading = false.obs;
  Future<bool> signUpWithEmailAndPassword() async {
    try {
      var requestBody = {
        "firstname": firstNameController.text,
        "lastname": lastNameController.text,
        "email": emailController.text,
        "pass": passwordController.text,
      };
      isSignUpLoading.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: requestBody,
        endpoint: zSignUpEndpoint,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        LocalStorageController.instance
            .setString(zEmail, decoded['data']['email']);
        LocalStorageController.instance.setInt(zUserId, decoded['data']['uid']);

        bool isOTPSent =
            await sendOTP(decoded['data']['uid'], decoded['data']['email']);
        isSignUpLoading.value = false;

        ///Set OneSignal user id
        ///Here the employee id will saved as Onesignal external user id
        if (!kIsWeb) {
          OneSignal.login(decoded['data']['uid'].toString());
        }

        if (isOTPSent) {
          return true;
        }
      } else {
        if (decoded['success'] == false) {
          if (decoded['message'] ==
              'There is already an account associated with the provided email address.') {
            CustomSnackBarService()
                .showErrorSnackBar(message: "Email already exists");
          } else {
            CustomSnackBarService()
                .showErrorSnackBar(message: "Something went wrong");
          }
          isSignUpLoading.value = false;
          return false;
        }
      }
    } catch (e) {
      isSignUpLoading.value = false;
      return false;
    }
    isSignUpLoading.value = false;
    return false;
  }

  ///Sign In With Email and Password
  RxBool isSignInLoading = false.obs;
  Future<bool> signInWithEmailAndPassword() async {
    isSignInLoading.value = true;
    var token = await TokenMaker.instance.secureAPI(emailController.text);
    var certainty = token['certainty'];
    var security = token['security'];
    var requestBody = {
      "email": emailController.text,
      "password": passwordController.text,
      "certainty": certainty,
      "security": security,
    };
    var response = await ApiServices.instance.getResponse(
      requestBody: requestBody,
      endpoint: zSignInEndpoint,
    );
    try {
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        await LocalStorageController.instance
            .setString(zAuthToken, decoded['data']['auth_token']);
        await LocalStorageController.instance
            .setString(zAuthTokenValidTill, decoded['data']['validity']);
        LocalStorageController.instance.setBool(zIsLoggedIn, true);
        GlobalStorage.instance.isLogged = true;
        emailController.clear();
        passwordController.clear();
        isSignInLoading.value = false;
        return true;
      } else {
        if (decoded['success'] == false) {
          CustomSnackBarService()
              .showErrorSnackBar(message: "Invalid email or password");
        }
      }
    } catch (e) {
      print('Error signing in with email and password: $e');
    }
    isSignInLoading.value = false;
    return false;
  }

  ///Google Sign In
  Future<bool> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Get the GoogleSignInAuthentication object
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential using the Google Sign-In authentication
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Sign in to Firebase with the credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Get the Firebase user
      final User? user = userCredential.user;

      // Print Firebase ID
      print('Firebase ID: ${user!.uid}');

      // Print other user details
      print('Email: ${user.email}');

      print('Display Name: ${user.displayName}');
      print('Photo URL: ${user.photoURL}');

      Get.offAll(() => NavigationBarScreen());

      await LocalStorageController.instance
          .setString(zUserFullName, user.displayName!);

      // var token = await TokenMaker.instance.secureAPI(user.email!);
      //
      // var certainty = token['certainty'];
      // var security = token['security'];

      await signInWithSSO(
          email: user.email!,
          firebaseId: user.uid,
          certainty: "",
          security: "security");

      ///TODO: Need to add the functionality to save the user details in the database

      return true;
    } catch (e) {
      print('Error signing in with Google: $e');
      return false;
    }
  }

  Future<bool> signInWithSSO(
      {required String email,
      required String firebaseId,
      required String certainty,
      required String security}) async {
    try {
      isSignInLoading.value = true;
      print('Email: $email');
      print('Firebase ID: $firebaseId');
    } catch (e) {
      isSignInLoading.value = false;
      return false;
    }
    isSignInLoading.value = false;
    return false;
  }

  ///Apple Sign In
  Future<bool> signInWithApple() async {
    ///TODO: Implement Apple Sign In after getting the Apple Developer Account
    return true;
  }

  ///Validate User

  ///Send OTP
  Future<bool> sendOTP(int userId, String email) async {
    try {
      var requestBody = {
        "uid": userId,
        "email": email,
      };
      var response = await ApiServices.instance.getResponse(
        requestBody: requestBody,
        endpoint: zSendOtpEndpoint,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        if (decoded['success'] == false) {
          Get.snackbar(
            'Error',
            decoded['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: zErrorSwatch,
            colorText: zWhiteColor,
            duration: const Duration(seconds: 2),
          );
        }
        return false;
      }
    } catch (e) {
      print('Error sending OTP: $e');
      return false;
    }
  }

  ///Verify OTP
  Future<bool> verifyOTP(String otp) async {
    try {
      var requestBody = {
        "uid": await LocalStorageController.instance.getInt(zUserId),
        "email": await LocalStorageController.instance.getString(zEmail),
        "otp": int.parse(otp),
      };
      var response = await ApiServices.instance.getResponse(
        requestBody: requestBody,
        endpoint: zVerifyOtpEndpoint,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        LocalStorageController.instance
            .setString(zAuthToken, decoded['data']['auth_token']);
        LocalStorageController.instance
            .setString(zAuthTokenValidTill, decoded['data']['validity']);
        AuthController.instance.otpController.clear();
        LocalStorageController.instance.setBool(zIsLoggedIn, true);
        return true;
      } else {
        if (decoded['success'] == false) {
          Get.snackbar(
            'Error',
            decoded['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: zErrorSwatch,
            colorText: zWhiteColor,
            duration: const Duration(seconds: 2),
          );
        }
        AuthController.instance.otpController.clear();
        return false;
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      AuthController.instance.otpController.clear();
      return false;
    }
  }

  ///Forgot Password

  Future<bool> forgotPassword({required String email}) async {
    try {
      var requestBody = {
        "email": email,
      };
      var response = await ApiServices.instance.getResponse(
        requestBody: requestBody,
        endpoint: zForgotPasswordEndpoint,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        emailController.clear();
        Get.snackbar(
          'Success',
          "We've sent you an email with a link to reset your password",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: zSuccessSwatch,
          colorText: zWhiteColor,
          duration: const Duration(seconds: 3),
        );
        return true;
      } else {
        if (decoded['success'] == false) {
          Get.snackbar(
            'Error',
            decoded['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: zErrorSwatch,
            colorText: zWhiteColor,
            duration: const Duration(seconds: 2),
          );
        }
        return false;
      }
    } catch (e) {
      print('Error sending OTP: $e');
      return false;
    }
  }

  ///Sign Out
  Future<void> signOut() async {
    try {
      await LocalStorageController.instance.clearInstance(zAuthToken);
      await LocalStorageController.instance.clearInstance(zAuthTokenValidTill);
      await LocalStorageController.instance.clearInstance(zIsLoggedIn);
      await LocalStorageController.instance.clearInstance(zUserId);
      OneSignal.logout();
      Get.delete<CommonController>();
      Get.offAll(() => const SignInScreen());
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
