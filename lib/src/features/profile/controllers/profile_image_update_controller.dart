import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travsy/src/common/services/custom_snackbar_service.dart';
import 'package:travsy/src/features/profile/controllers/profile_controller.dart';
import 'package:travsy/src/utils/api_urls.dart';
import 'package:mime/mime.dart';

import '../../../common/contollers/local_storage_controller.dart';
import '../../../utils/app_constants.dart';

class ProfilePictureUploadController extends GetxController {
  static ProfilePictureUploadController instance = Get.find();
  @override
  RxString imagePath = ''.obs;
  RxBool isImageUploading = false.obs;
  //int userId = GlobalStorage.to.userId;
  int uploadStatus = 0;
  List<String> imageExtensions = [
    "png",
    "jpg",
    "jpeg",
    "gif",
    "bmp",
    "webp",
    "tiff",
    "heic",
    "heif"
  ];
  RxString extension = ''.obs;
  // Future getImage()async {
  //   try {
  //     final ImagePicker picker = ImagePicker();
  //     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //     if (image != null) {
  //       final File file = File(image.path);
  //       _tempAvatar = file;
  //       _avatarUploading = true;
  //       notifyListeners();
  //       final bool status = await _repository.updateUserAvatar(file);
  //       getCurrentUserProfile();
  //       _avatarUploading = false;
  //       notifyListeners();
  //       return status;
  //     }
  //   } catch (_) {
  //     return false;
  //   }
  // }
  Future getImage() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedImage;
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    extension.value = pickedImage!.path.split('.').last;
    print(extension.value);
    print(imageExtensions.contains(extension.value));
    print(pickedImage.path.toString());
    if (pickedImage != null) {
      if (imageExtensions.contains(extension.value)) {
        imagePath.value = pickedImage.path.toString();
      } else {
        imagePath.value = '';
        CustomSnackBarService().showWarningSnackBar(
            message: "Valid image formats are png, jpg, jpeg and heic");
      }
    }
  }

  Future<bool> updatePhoto() async {
    try {
      http.MultipartRequest request = http.MultipartRequest(
          'POST', Uri.parse(zApiDomain + zUpdatePhotoEndpoint));
      var authToken =
          await LocalStorageController.instance.getString(zAuthToken);
      var headers = {'Accept': '*/*', 'Authorization': 'Bearer $authToken'};
      request.headers.addAll(headers);

      File file = File(imagePath.value);

      print("MIME: ${lookupMimeType(imagePath.value)}");
      var mimeType = lookupMimeType(imagePath.value) ?? 'image/jpeg';
      var mediaType = MediaType.parse(mimeType);
      request.files.add(await http.MultipartFile.fromPath('image', file.path,
          contentType: mediaType));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseString = await response.stream.bytesToString();
        print(responseString);
        print("Image uploaded successfully");
        ProfileController.instance.fetchProfile();
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
  //
  // Future<bool> updatePhoto() async {
  //   if (imagePath.value == "") {
  //     Get.snackbar(
  //       "Error",
  //       "Please select an image. Valid image formats are png, jpg, jpeg and heic",
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: zErrorSwatch,
  //       colorText: zTextColorLight,
  //     );
  //     return false;
  //   }
  //   if (imageExtensions.contains(extension.value)) {
  //     var uri = Uri.parse(zApiDomain + zUpdatePhotoEndpoint);
  //
  //     var request = http.MultipartRequest('POST', uri);
  //     var authToken =
  //         await LocalStorageController.instance.getString(zAuthToken);
  //     var headers = {
  //       'Accept': 'application/json',
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $authToken'
  //     };
  //     request.headers.addAll(headers);
  //     // Map<String, String> requestBody = {};
  //     // request.fields.addAll(requestBody);
  //     // Add the file to the request
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'image',
  //         imagePath.value,
  //       ),
  //     );
  //     print(request.fields);
  //     print(request.headers);
  //
  //     try {
  //       isImageUploading.value = true;
  //       var response = await request.send();
  //       var responseData = await response.stream.bytesToString();
  //       print(responseData);
  //       print(response.statusCode);
  //
  //       if (response.statusCode >= 200 && response.statusCode < 300) {
  //         uploadStatus = 1;
  //         isImageUploading.value = false;
  //         return true;
  //       } else {
  //         Get.snackbar(
  //           "Try Again",
  //           await response.stream.bytesToString(),
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: zErrorSwatch,
  //           colorText: zTextColorLight,
  //         );
  //       }
  //       isImageUploading.value = false;
  //       return false;
  //     } catch (error) {
  //       Get.snackbar(
  //         "Try again",
  //         "Try with a different image",
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: zErrorSwatch,
  //         colorText: zTextColorLight,
  //       );
  //       isImageUploading.value = false;
  //       return false;
  //     }
  //   } else {
  //     print(imagePath.value);
  //     Get.snackbar(
  //       "Error",
  //       "Please select an image. Valid image formats are png, jpg, jpeg and heic",
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: zErrorSwatch,
  //       colorText: zTextColorLight,
  //     );
  //     isImageUploading.value = false;
  //     return false;
  //   }
  // }
}
