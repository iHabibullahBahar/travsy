import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:travsy/src/utils/api_urls.dart';
import 'package:travsy/src/utils/colors.dart';

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
  Future getImage() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedImage;
    pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 60,
        maxHeight: 500,
        maxWidth: 500);
    extension.value = pickedImage!.path.split('.').last;
    print(extension.value);
    print(imageExtensions.contains(extension.value));
    print(pickedImage.path.toString());
    if (pickedImage != null) {
      if (imageExtensions.contains(extension.value)) {
        imagePath.value = pickedImage.path.toString();
      } else {
        imagePath.value = '';
        Get.snackbar(
          "Oops, Invalid Image",
          "Valid image formats are png, jpg, jpeg and heic",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: zErrorSwatch,
          colorText: zTextColorLight,
        );
      }
    }
  }

  Future<bool> updatePhoto() async {
    if (imagePath.value == "") {
      Get.snackbar(
        "Error",
        "Please select an image. Valid image formats are png, jpg, jpeg and heic",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: zErrorSwatch,
        colorText: zTextColorLight,
      );
      return false;
    }
    if (imageExtensions.contains(extension.value)) {
      var uri = Uri.parse(zApiDomain + zUpdateProfilePhotoEndPoint);
      var request = http.MultipartRequest('POST', uri);
      Map<String, String> requestBody = {
        ///TODO: Add user id
        "user_id": "user"
      };
      request.fields.addAll(requestBody);
      // Add the file to the request
      request.files.add(
        await http.MultipartFile.fromPath(
          'profile_photo',
          imagePath.value,
        ),
      );
      try {
        isImageUploading.value = true;
        var response = await request.send();
        var responseData = await response.stream.bytesToString();
        print(responseData);
        print(response.statusCode);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          uploadStatus = 1;
          isImageUploading.value = false;
          return true;
        } else {
          Get.snackbar(
            "Try Again",
            await response.stream.bytesToString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: zErrorSwatch,
            colorText: zTextColorLight,
          );
        }
        isImageUploading.value = false;
        return false;
      } catch (error) {
        Get.snackbar(
          "Try again",
          "Try with a different image",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: zErrorSwatch,
          colorText: zTextColorLight,
        );
        isImageUploading.value = false;
        return false;
      }
    } else {
      print(imagePath.value);
      Get.snackbar(
        "Error",
        "Please select an image. Valid image formats are png, jpg, jpeg and heic",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: zErrorSwatch,
        colorText: zTextColorLight,
      );
      isImageUploading.value = false;
      return false;
    }
  }
}
